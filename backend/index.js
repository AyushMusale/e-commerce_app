require("dotenv").config();
const express = require("express");
const auth_router = require('./routes/auth')
const seller_router = require('./routes/seller')
const {jwtAuth} = require('./services/jwtAuth')
const { checkusersession } = require("./middleware/checkusersession");

const mongoose = require('mongoose')

const app = express()
const port = 5000

mongoose.connect(process.env.MONGODB_URI)
.then(()=> console.log("MongoServer started"))
.catch((err)=>{
    console.log(err)
})

app.use(express.json())

app.use('/api/ECAPP/auth', auth_router)
app.use('/api/ECAPP/seller', jwtAuth, checkusersession ,seller_router)

app.post('/api/ECAPP/test', jwtAuth, (req,res)=>{
    return res.json({
        'status': 'working',
    })
})


app.listen(port, ()=>{
    console.log("sever started");
})