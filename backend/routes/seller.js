const express = require("express");
const { addProduct } = require("../handlers/addproduct");
const upload = require("../middleware/multer");
const { jwtAuth } = require("../middleware/jwtAuth");
const { validateReq } = require("../validators/sellerprofilevalidator");
const { sellerprofille } = require("../handlers/sellerprofile");

const router = express.Router();
// /api/ECAPP/seller/
router.post("/addproduct", jwtAuth, upload.array("images"), addProduct);

router.post("/profile", validateReq, sellerprofille);

module.exports = router;
