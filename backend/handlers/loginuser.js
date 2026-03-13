const pool = require("../DBconnection");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

async function loginUser(req, res) {
  try {
    let { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({
        status: 400,
        message: "fields-requuired",
      });
    }

    email = email.toLowerCase();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!emailRegex.test(email)) {
      return res.status(400).json({
        status: 400,
        message: "invalid-email",
      });
    }

    const [rows] = await pool.execute(
      "SELECT id,email, password_hash, user_role FROM users WHERE email=?",
      [email],
    );

    if (rows.length == 0) {
      return res.status(401).json({
        status: 401,
        message: "invalid-credentials",
      });
    }

    const user = rows[0];
    const isMatch = await bcrypt.compare(password, user.password_hash);

    if (!isMatch) {
      return res.status(401).json({
        status: 401,
        message: "invalid-credentails",
      });
    }

    const token = jwt.sign(
      {
        id: user.id,
        email: email,
        role: user.user_role,
      },
      process.env.JWT_SECRET,
      {
        expiresIn: "15m",
      },
    );
    const refToken = jwt.sign(
      {
        id: user.id,
      },
      process.env.JWT_REFRESH_SECRET,
      {
        expiresIn: "15d",
      },
    );

    await pool.execute("UPDATE users set refresh_token = ? WHERE id = ?", [
      refToken,
      user.id,
    ]);

    return res.status(200).json({
      status: 200,
      message: "successful-login",
      access_token: token,
      user: {
        email: email,
        id: user.id,
      },
    });
  } catch (e) {
    return res.status(500).json({
      status: 500,
      message: "login-failed",
    });
  }
}

module.exports = { loginUser };
