const express = require("express");
const { getHomePage } = require("../handlers/customerhomepage");
const { fetchproduct } = require("../handlers/fetchproduct");
const { jwtAuth } = require("../middleware/jwtAuth");
const {
  updateCart,
  getCart,
  removeCartItem,
} = require("../handlers/carthandler");
const {
  validateCustomerDetails,
} = require("../validators/customerprofilevalidator");
const { searchHandler } = require("../handlers/searchhandlers");
const {
  StoreCustomerProfileHandler,
  getCustomerProfile,
} = require("../handlers/customerprofile");
const { CreateOrder, VerifyPayment } = require("../handlers/order");

const router = express.Router();

router.get("/home", jwtAuth, getHomePage);
router.get("/product/:id", jwtAuth, fetchproduct);
router.post("/cart", jwtAuth, updateCart);
router.get("/cart", jwtAuth, getCart);
router.delete("/cart/:product_id", jwtAuth, removeCartItem);
router.post(
  "/profile",
  jwtAuth,
  validateCustomerDetails,
  StoreCustomerProfileHandler,
);
router.get("/profile", jwtAuth, getCustomerProfile);
router.get("/search/:keyword", searchHandler);
router.post("/order", jwtAuth, CreateOrder);
router.post("/verify-payment", jwtAuth, VerifyPayment);

module.exports = router;
