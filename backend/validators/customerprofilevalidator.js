const { z, regex } = require("zod");

const ProfileSchema = z.object({
  last_name: z.string().min(1, "Last name required"),
  first_name: z.string().min(1, "First Name Required"),
  address: z.string().min(1, "Address Requires"),
  pincode: z
    .string()
    .regex(/^\d{6}$/, "Valid Pincode Required")
    .transform((val) => Number(val)),
  city: z.string().min(1, "City Required"),
  email: z.email('Invalid-Email'),
  phone_no: z.string().min(10, 'invalid phone number')
});

function validateCustomerDetails(req, res, next) {
  const result = ProfileSchema.safeParse(req.body);
  if (!result.success) {
    const error = result.error.issues[0].message;
    return res.status(400).json({
      message: error,
    });
  }
  req.validatedCustomerDetails = result.data,
  next()
}


module.exports={validateCustomerDetails}