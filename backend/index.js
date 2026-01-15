require("dotenv").config();
const express = require("express");
const reg_router =  require("./routes/registration")

const app = express()
const port = 5000

app.use(express.json())

app.use('/api/ECAPP/signup', reg_router)
app.use('/api/ECAPP/test', (req, res)=>{
    console.log("test hit")
})
app.listen(port, ()=>{
    console.log("sever started");
})