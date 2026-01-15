const express = require("express")
const {registerUser} = require('../handlers/regiteruser')

const reg_router = express.Router()

reg_router.post("/", registerUser)

module.exports = reg_router