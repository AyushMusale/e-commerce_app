const express = require('express')
const {loginUser} = require('../handlers/loginuser')
const router = express.Router();

router.post('/', loginUser)

module.exports = router;