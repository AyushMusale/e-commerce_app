const Product = require("../models/product");

async function fetchSellersProduct(req, res) {
  try {
    // seller id comes from jwtAuth -> req.user
    const sellerId = req.user?.id;
    if (!sellerId) {
      return res.status(401).json({
        message: "unauthorized",
      });
    }

    const products = await Product.find({ sellerId: sellerId });
    if (!products) {
      return res.status(404).json({
        message: "no products found",
      });
    }
    const baseUrl = "http://10.0.2.2:5000";
    const formatProducts = products.map((product) => {
      return {
        ...product._doc,
        images: product.images.map((img) => {
          const cleanPath = img.replace(/\\/g, "/");
          return `${baseUrl}/${cleanPath}`;
        }),
      };
    });
    return res.status(200).json({
      message: "success",
      products: formatProducts,
    });
  } catch (e) {
    return res.status(500).json({
      message: "server-error",
    });
  }
}

module.exports = { fetchSellersProduct };