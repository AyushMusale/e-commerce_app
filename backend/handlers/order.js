const { pool } = require("../DBconnection");
const { Cart } = require("../models/cart");
const { Order } = require("../models/order");
const Product = require("../models/product");
const crypto = require("crypto");
const { razorpay } = require("../services/razorpay");

async function CreateOrder(req, res) {
  try {
    const { id } = req.user;

    const cart = await Cart.findOne({ user_id: id }).populate(
      "cart_items.product",
    );
    if (!cart || cart.cart_items.length === 0) {
      return res.status(400).json({
        message: "cart-empty",
      });
    }

    const [customerRows] = await pool.execute(
      "SELECT email,last_name,first_name,phone_no,address,city,pincode from customer where customer_id = ?",
      [id],
    );

    if (customerRows.length === 0) {
      return res.status(400).json({
        message: "customer-profile-required",
      });
    }

    const invalidItem = cart.cart_items.find(
      (item) => !item.product || item.quantity < 1,
    );
    if (invalidItem) {
      return res.status(400).json({
        message: "invalid-cart-item",
      });
    }

    const outOfStockItem = cart.cart_items.find((item) => {
      const stock = item.product.inStock;
      const n =
        typeof stock === "number"
          ? stock
          : stock === true
            ? 10
            : stock === false
              ? 0
              : 0;
      return n < item.quantity;
    });
    if (outOfStockItem) {
      return res.status(400).json({
        message: "product-out-of-stock",
      });
    }

    let totalAmount = 0;
    const orderItems = cart.cart_items.map((item) => {
      const currentProduct = item.product;
      const lineTotal = currentProduct.price * item.quantity;
      totalAmount += lineTotal;

      return {
        product_id: currentProduct._id,
        name: currentProduct.name,
        price: currentProduct.price,
        quantity: item.quantity,
        images: currentProduct.images,
        sellerId: currentProduct.sellerId,
      };
    });

    // const existingOrder = await Order.findOne({
    //   user_id: id,
    //   payment_status: "pending",
    // });

    // if (existingOrder) {
    //   const rupees = existingOrder.total_amount;
    //   return res.status(200).json({
    //     message: "existing-order",
    //     order_id: existingOrder._id,
    //     total_amount: rupees,
    //     total_amount_paise: Math.round(rupees * 100),
    //     razorpay_order_id: existingOrder.razorpay_order_id,
    //     razorpay_key: process.env.RAZORPAY_ID,
    //     payment_status: existingOrder.payment_status,
    //     order_status: existingOrder.order_status,
    //   });
    // }

    const razorpayOrder = await razorpay.orders.create({
      amount: totalAmount * 100,
      currency: "INR",
      receipt: `order_${id}_${Date.now()}`,
      notes: {
        user_id: id,
      },
    });

    const customer = customerRows[0];

    const order = await Order.create({
      user_id: id,
      items: orderItems,
      total_amount: totalAmount,
      razorpay_order_id: razorpayOrder.id,
      shipping_details: {
        first_name: customer.first_name,
        last_name: customer.last_name,
        email: customer.email,
        phone_no: customer.phone_no,
        address: customer.address,
        city: customer.city,
        pincode: customer.pincode,
      },
    });

    return res.status(201).json({
      message: "success",
      order_id: order._id,
      total_amount: order.total_amount,
      total_amount_paise: Math.round(totalAmount * 100),
      razorpay_order_id: razorpayOrder.id,
      razorpay_key: process.env.RAZORPAY_ID,
      order_status: order.order_status,
      payment_status: order.payment_status,
    });
  } catch (e) {
    return res.status(500).json({
      message: "server error",
    });
  }
}

async function VerifyPayment(req, res) {
  try {
    const { razorpay_order_id, razorpay_payment_id, razorpay_signature } =
      req.body;

    if (!razorpay_order_id || !razorpay_payment_id || !razorpay_signature) {
      return res.status(400).json({
        message: "missing-fields",
      });
    }

    const generatedSignature = crypto
      .createHmac("sha256", process.env.RAZORPAY_SECRET)
      .update(`${razorpay_order_id}|${razorpay_payment_id}`)
      .digest("hex");

    if (generatedSignature !== razorpay_signature) {
      return res.status(400).json({
        message: "invalid-payment",
      });
    }

    const order = await Order.findOne({ razorpay_order_id });

    if (!order) {
      return res.status(404).json({
        message: "order-not-found",
      });
    }

    if (order.payment_status === "paid") {
      return res.status(200).json({
        message: "already-verified",
        order_id: order._id.toString(),
        razorpay_order_id: order.razorpay_order_id,
        razorpay_payment_id:
          order.razorpay_payment_id || razorpay_payment_id,
        razorpay_signature,
      });
    }
    order.payment_status = "paid";
    order.razorpay_payment_id = razorpay_payment_id;
    await order.save();

    await Promise.all(
      order.items.map((item) =>
        Product.findByIdAndUpdate(item.product_id, {
          $inc: {
            soldCount: item.quantity,
            inStock: -item.quantity,
          },
        }),
      ),
    );

    await Cart.updateOne(
      { user_id: order.user_id },
      { $set: { cart_items: [] } },
    );

    return res.status(200).json({
      message: "payment-verified",
      order_id: order._id.toString(),
      razorpay_order_id,
      razorpay_payment_id,
      razorpay_signature,
    });
  } catch (error) {
    return res.status(500).json({
      message: "server-error",
    });
  }
}
module.exports = { CreateOrder, VerifyPayment };
