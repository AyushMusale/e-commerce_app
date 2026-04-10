const bcrypt = require("bcrypt");
const {pool} = require("../DBconnection");

async function registerUser(req, res) {
  try {
    let { email, password, user_role } = req.body;

    if (!email || !password || !user_role) {
      return res.status(400).json({
        status: 400,
        message: "fields-required",
      });
    }

    email = email.toLowerCase();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!emailRegex.test(email)) {
      return res.status(400).json({
        status: 400,
        message: "email-invalid",
      });
    }
    if (password.length < 6) {
      return res.status(400).json({
        status: 400,
        message: "password-invalid",
      });
    }
    const password_hash = await bcrypt.hash(password, 10);

    const [result] = await pool.execute(
      "INSERT INTO users(email, password_hash, user_role, refresh_token) VALUES (?,?,?,?)",
      [email, password_hash, user_role, "no-refresh-token"]
    );

    return res.status(201).json({
      id: result.insertId,
      email: email,
      status: 201,
      message: 'success'
    });
  } catch (e) {
    if (e.code === "ER_DUP_ENTRY") {
      return res.status(409).json({
        status: 409,
        message: "email-already-exists"
      });
    }
    return res.status(500).json({
      status: 500,
      message: 'error'
    });
  }
}

module.exports = { registerUser };
