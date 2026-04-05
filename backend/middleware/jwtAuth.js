const jwt = require("jsonwebtoken");


function jwtAuth(req, res, next) {
  const authHeader = req.headers.authorization;
  if (!authHeader) {
    return res.status(401).json({
      status: 401,
      message: "access-token-required",
    });
  }
  const parts = authHeader.split(" ");
  if (parts.length !== 2 || parts[0] !== "Bearer") {
    return res.status(401).json({
      status: 401,
      message: "invalid-token-format",
    });
  }
  const token = parts[1];

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    next();
  } catch (e) {
    if (e.name === "TokenExpiredError")
      return res.status(401).json({
        message: "access-token-expired",
      });

    return res.status(401).json({
      status: 401,
      message: "access-token-invalid",
    });
  }
}

module.exports = { jwtAuth };
