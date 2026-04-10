const {pool} = require("../DBconnection");

async function sellerprofille(req, res) {
  const data = req.validatedData;
  const id = req.user.id;
  try {
    await pool.query(
      "INSERT INTO seller(seller_id,shop_name,owner_name,phone_no,email,shop_address,city,pincode) VALUES (?,?,?,?,?,?,?,?)",
      [id,
      data.shop_name,
      data.owner_name,
      data.phone_no,
      data.email,
      data.shop_address,
      data.city,
      data.pincode,]
    );

    return res.status(200).json({
        shop_name: data.shop_name,
        owner_name: data.owner_name,
        phone_no: data.phone_no,
        email: data.email,
        shop_address: data.shop_address,
        city: data.city,
        pincode: data.pincode.toString(),
        message: "success",
    })

  } catch (e) {
    return res.status(500).json({
        message: 'server-error',
    })
  }
}

module.exports = {sellerprofille}