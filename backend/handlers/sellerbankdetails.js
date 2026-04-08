const { pool } = require("../DBconnection");
const bcrypt = require("bcrypt");

async function sellerBankdetailsHandler(req, res) {
  try {
    const { account_holder_name, account_number, ifsc } =
      req.validatedBankdetails;
    const { id } = req.user;
    const account_last4 = account_number.slice(-4);

    const encrypted_account_number = await bcrypt.hash(account_number, 5);

    await pool.execute(
      `INSERT INTO sellerBankdetails 
      (seller_id, account_holder_name, account_number, account_last4, ifsc)
      VALUES (?, ?, ?, ?, ?)`,
      [id, account_holder_name, encrypted_account_number, account_last4, ifsc],
    );
  } catch (e) {
    return res.status(500).json({
      message: "server-error",
    });
  }
}

async function getSellerBankDetails(req, res) {
  try {
    const { id } = req.user;
    const [rows] = await pool.execute(
      `SELECT account_holder_name, account_last4, ifsc FROM sellerBankdetails where seller_id = ?`,
      [id],
    );

    if (rows.length === 0) {
      return res.status(404).json({
        message: "no details found",
      });
    }

    const details = rows[0];
    return res.status(200).json({
      message: "success",
      bank_details: {
        account_last4: details.account_last4,
        account_holder_name: details.account_holder_name,
        ifsc: details.ifsc,
      },
    });
  } catch (e) {
    return res.status(500).json({
      message: "server-error",
    });
  }
}


module.exports = {sellerBankdetailsHandler,getSellerBankDetails}