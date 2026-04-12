const { Cart } = require("../models/cart");
const { rawListeners } = require("../models/product");

//res= {
// 'cart_items': [{prduct: 'product_id', quantity: 2}]
//}

async function updateCart(req, res) {
  try {
    const user = req.user;
    const { cart_items } = req.body;

    if (!Array.isArray(cart_items)) {
      return res.status(400).json({
        message: "invalid cart",
      });
    }

    let cart = await Cart.findOne({
      user_id: user.id,
    });

    if (cart) {
      cart.cart_items = cart_items;
      await cart.save();
    } else {
      cart = await Cart.create({
        user_id: user.id,
        cart_items: cart_items,
      });
    }

    return res.status(200).json({
      message: "success",
    });
  } catch (e) {
    return res.status(500).json({
      message: "server-error",
    });
  }
}

//get request
async function getCart(req, res) {
  try {
    const { id } = req.user;

    const cart = await Cart.findOne({ user_id: id }).populate(
      "cart_items.product",
      "id name price images",
    );
    if (!cart || cart.cart_items.length === 0) {
      return res.status(200).json({
        message: "No item in Cart",
      });
    }

    const baseUrl = "http://10.0.2.2:5000";
    const formatCart = cart.cart_items.map((item) => {
      const product = item.product;

      const formattedProduct = {
        _id: product._id,
        name: product.name,
        price: product.price,
        images: product.images.map((img) => {
          const cleanPath = img.replace(/\\/g, "/");
          return `${baseUrl}/${cleanPath}`;
        }),
      };

      return {
        product: formattedProduct,
        quantity: item.quantity,
      };
    });

    console.log('user id', id);
    return res.status(200).json({
      message: "success",
      cart_items: formatCart,
    });
  } catch (e) {
    return res.status(500).json({
      message: "server error",
    });
  }
}

async function removeCartItem(req, res) {
  try {
    const { id } = req.user;
    const { product_id } = req.params;  

    if (!product_id) {
      return res.status(400).json({
        message: "product id required",
      });
    }
    const cart = await Cart.findOne({ user_id: id });

    if (!cart) {
      return res.status(404).json({
        message: "cart-not-found",
      });
    }

    const updateCart = await Cart.findOneAndUpdate(
      { user_id: id },
      {
        $pull: {
          cart_items: {
            product: product_id,
          },
        },
      },
      { new: true },
    ).populate("cart_items.product", "id name price images");

    const baseUrl = "http://10.0.2.2:5000";
    const formatCart = updateCart.cart_items.map((item) => {
      const product = item.product;

      const formattedProduct = {
        _id: product._id,
        name: product.name,
        price: product.price,
        images: product.images.map((img) => {
          const cleanPath = img.replace(/\\/g, "/");
          return `${baseUrl}/${cleanPath}`;
        }),
      };

      return {
        product: formattedProduct,
        quantity: item.quantity,
      };
    });

    return res.status(200).json({
      message: "success",
      cart_items: formatCart,
    });
  } catch (e) {
    return res.status(500).json({
      message: "server-error",
    });
  }
}

module.exports = { updateCart, getCart, removeCartItem };
