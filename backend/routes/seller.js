const express = require("express");
const { addProduct } = require("../handlers/addproduct");
const upload = require("../middleware/multer");
const { jwtAuth } = require("../middleware/jwtAuth");
const { validateReq } = require("../validators/sellerprofilevalidator");
const { sellerprofille } = require("../handlers/sellerprofile");
const {sellerBankdetailsHandler,getSellerBankDetails} = require('../handlers/sellerbankdetails')
const {validatedBankdetails} = require('../validators/bankdetailsvalidator')
const { fetchSellersProduct } = require("../handlers/fetchsellersproduct");
const router = express.Router();
// /api/ECAPP/seller/
router.post("/addproduct", jwtAuth, upload.array("images"), addProduct);

router.post("/profile", validateReq, sellerprofille);
router.post('/bankdetails', jwtAuth, validatedBankdetails,sellerBankdetailsHandler)
router.get('/bankdetails',jwtAuth,getSellerBankDetails)
router.get('/products', jwtAuth, fetchSellersProduct);

module.exports = router;
