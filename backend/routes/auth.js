const express = require("express");
const { loginUser } = require("../handlers/loginuser");
const { registerUser } = require("../handlers/regiteruser");
const { getAccessToken } = require("../handlers/getnewtoken");
const router = express.Router();

router.post("/login", loginUser);
router.post("/signup", registerUser);
router.post('/token', getAccessToken)


module.exports = router;
