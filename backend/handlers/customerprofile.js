const { pool } = require("../DBconnection");

async function StoreCustomerProfileHandler(req, res) {
  try {
    const { id } = req.user;
    const data = req.validatedCustomerDetails;
    console.log(data,id)
    await pool.execute(
      "Insert Into customer(customer_id,email,last_name,first_name,phone_no,address,city,pincode) values(?,?,?,?,?,?,?,?)",
      [
        id,
        data.email,
        data.last_name,
        data.first_name,
        data.phone_no,
        data.address,
        data.city,
        data.pincode,
      ],
    );
    return res.status(200).json({
      message: "success",
    });
  } catch (e) {
    console.log(e);
    return res.status(500).json({
      message: "server-error",
    });
  }
}

async function getCustomerProfile(req, res) {
  try{const { id } = req.user;
  const [rows] = await pool.execute(
    "SELECT email,last_name,first_name,phone_no,address,city,pincode from customer where customer_id = ?",
    [id],
  );

  if (rows.length === 0) {
    return res.status(404).json({
      message: "no data",
    });
  }

  const user = rows[0]

  return res.status(200).json({
    message:'success',
    profile: user
  })}catch(e){
    console.log(e)
    return res.status(500).json({
        message: 'server-error'
    })
  }
}

module.exports = { StoreCustomerProfileHandler , getCustomerProfile };
