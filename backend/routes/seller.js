const express = require('express')
const {addProduct} = require('../handlers/addproduct')

const router = express.Router();

router.post('/addproduct', addProduct)


module.exports = router;