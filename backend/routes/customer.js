const express = require("express");
const { getHomePage } = require("../handlers/customerhomepage");
const { fetchproduct } = require("../handlers/fetchproduct");
const { jwtAuth } = require("../middleware/jwtAuth");
const { updateCart, getCart , removeCartItem} = require("../handlers/carthandler");

const router = express.Router();

router.get("/home", jwtAuth, getHomePage);
router.get("/product/:id", jwtAuth, fetchproduct);
router.post("/cart", jwtAuth, updateCart);
router.get("/cart", jwtAuth, getCart);
router.delete('/cart/:product_id', jwtAuth, removeCartItem)

module.exports = router;
