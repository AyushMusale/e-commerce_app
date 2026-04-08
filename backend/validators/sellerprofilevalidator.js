const {z} = require('zod')


const sellerSchema = z.object({
    shop_name:z.string().min(1,"shop-name-required"),
    owner_name:z.string().min(1,"owner-name-required"),

    phone_no:z.string().regex(/^[6-9]\d{9}$/,"invalid-phone-number"),
    email:z.email("invalid-email"),

    shop_address:z.string().min(1, "address-required"),
    city:z.string().min(1,"city-required"),

    pincode:z.string().regex(/^\d{6}$/,"invalid-pincode").transform(val=>Number(val)),
})

function validateReq(req,res,next){
    const result = sellerSchema.safeParse(req.body)
   if(!result.success){
       const error = result.error.issues[0].message
        return res.status(400).json({
            message:error,
        })
    }
    
    req.validatedData = result.data
    next()
}

module.exports = {validateReq}