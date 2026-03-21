const express = require('express')
const {addProduct} = require('../handlers/addproduct')
const  upload = require('../middleware/multer');
const { jwtAuth } = require('../middleware/jwtAuth');

const router = express.Router();
// /api/ECAPP/seller/
router.post('/addproduct', (req,res,next)=>{
    console.log('route hit');
    next();
},jwtAuth,(req, res, next) => {
    upload.array("images")(req, res, function (err) {
      if (err) {
        console.log("MULTER ERROR:", err); // 🔥 THIS WILL SHOW TRUTH
        return res.status(500).json({ message: "multer failed" });
      }
      next();
    });
  },addProduct)

module.exports = router;