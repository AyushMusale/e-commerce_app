const {z} =require('zod')

const bankSchema  = z.object({
    account_holder_name: z.string().min(1, 'account holder\'s name reqired'),
    ifsc: z.string().min(1, 'ifsc code required'),
    account_number: z.string().min(1,'account number required')
})

function validatedBankdetails(req,res){
    const result = bankSchema.safeParse(req.body)
    if(!result.success){
        const error = result.error.issues[0].message
        return res.status(400).json({
            message:error
        })
    }

    req.validatedBankdetails = result.data
    next()
}

module.exports = {validatedBankdetails}