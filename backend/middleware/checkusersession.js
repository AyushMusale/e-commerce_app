const jwt = require("jsonwebtoken");

async function checkusersession(req, res, next) {
  try {
    const { access_token } = req.body;
    const decoded = jwt.verify(access_token, process.env.JWT_SECRET);
    req.user = decoded;
    if (!decoded.access_token) {
      return res.status(400).json({
        message: "access-token-required",
      });
    }
    if (next) {
      return next();
    }
  } catch (err) {
    if (err.name === "TokenExpiredError")
      return res.status(401).json({
        message: "access-token-expired",
      });

    return res.status(401).json({
      message: "access-token-invalid",
    });
  }
}

module.exports = {checkusersession};
