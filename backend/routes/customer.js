const express = require("express");
const { getHomePage } = require("../handlers/customerhomepage");
const { fetchproduct } = require("../handlers/fetchproduct");
const { jwtAuth } = require("../middleware/jwtAuth");

const router = express.Router();

router.get("/home", jwtAuth, getHomePage);
router.get("/product/:id", jwtAuth, fetchproduct);

module.exports = router;
