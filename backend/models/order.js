const mongoose = require("mongoose");

const OrderItemSchema = new mongoose.Schema(
  {
    product_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Product",
      required: true,
    },
    name: {
      type: String,
      required: true,
    },
    price: {
      type: Number,
      required: true,
      min: 0,
    },
    quantity: {
      type: Number,
      required: true,
      min: 1,
    },
    images: {
      type: [String],
      default: [],
    },
    sellerId: {
      type: Number,
      required: true,
    },
  },
  { _id: false },
);

const OrderSchema = new mongoose.Schema(
  {
    user_id: {
      type: Number,
      required: true,
      index: true,
    },
    items: {
      type: [OrderItemSchema],
      required: true,
      validate: [(value) => value.length > 0, "order-items-required"],
    },
    total_amount: {
      type: Number,
      required: true,
      min: 0,
    },
    payment_status: {
      type: String,
      enum: ["pending", "paid", "failed"],
      default: "pending",
    },
    order_status: {
      type: String,
      enum: ["placed", "processing", "shipped", "delivered", "cancelled"],
      default: "placed",
    },
    razorpay_order_id: {
      type: String,
      required: true,
    },
    razorpay_payment_id:{
      type: String,
      required: false,
    },
    shipping_details: {
      first_name: { type: String, required: true },
      last_name: { type: String, required: true },
      email: { type: String, required: true },
      phone_no: { type: String, required: true },
      address: { type: String, required: true },
      city: { type: String, required: true },
      pincode: { type: Number, required: true },
    },
  },
  { timestamps: true },
);

const Order = mongoose.model("Order", OrderSchema);

module.exports = { Order };
