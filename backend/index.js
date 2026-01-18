require("dotenv").config();
const express = require("express");
const reg_router =  require("./routes/registration")
const login_router = require('./routes/login')
const {jwtAuth} = require('./services/jwtAuth')

const app = express()
const port = 5000

app.use(express.json())

app.use('/api/ECAPP/signup', reg_router)
app.use('/api/ECAPP/login', login_router)
app.post('/api/ECAPP/test', jwtAuth, (req,res)=>{
    return res.json({
        'status': 'working',
    })
})


app.listen(port, ()=>{
    console.log("sever started");
})