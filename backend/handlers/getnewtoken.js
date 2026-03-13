const jwt = require("jsonwebtoken");
const {pool} = require("../DBconnection")

//req constains refresh token,
//check refresh token for validity if valid send new access token
//if the req[refeshtoken] is expired send logout res
async function getAccessToken(req, res) {
  try {
    const { refresh_token } = req.body;
    if (!refresh_token) {
      return res.status(400).json({
        "message": "refresh-token-required",
      });
    }
    const decoded = jwt.verify(refresh_token, process.env.JWT_REFRESH_SECRET);

    if (!decoded.id) {
      return res.status(401).json({
       "message": "invalid-token",
      });
    }

    const [rows] = await pool.execute(
      "SELECT id,email,user_role FROM users WHERE id=? AND refresh_token = ?",
      [decoded.id, refresh_token],
    );

    if (rows.length === 0) {
      return res.status(401).json({
       "message": "invalid-session",
      });
    }
    const user = rows[0];

    const newAccessToken = jwt.sign(
      {
        id: user.id,
        email: user.email,
        role: user.user_role,
      },
      process.env.JWT_SECRET,
      {
        expiresIn: "15m",
      },
    );

    const newRefreshToken = jwt.sign(
      {
        id: user.id,
      },
      process.env.JWT_REFRESH_SECRET,
      {
        expiresIn: "15d",
      },
    );

    await pool.execute("UPDATE users set refresh_token = ? where id = ?", [
      newRefreshToken,
      user.id,
    ]);
    return res.json({
      "access_token": newAccessToken,
      "refresh_token": newRefreshToken,
    });
  } catch (e) {
    if (e.name === "TokenExpiredError") {
      return res.status(401).json({
        "message": "refresh-token-expired",
      });
    }

    return res.status(401).json({
      "message": "refresh-token-invalid",
    });
  }
}

module.exports = {getAccessToken};
