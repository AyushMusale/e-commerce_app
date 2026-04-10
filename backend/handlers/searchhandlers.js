const Product = require("../models/product");

async function searchHandler(req, res) {
  try {
    const { keyword } = req.params;
    if (!keyword) {
      return res.status(400).json({
        message: "keyword is required",
      });
    }

    const products = await Product.find({
      $or: [
        { name: { $regex: keyword, $options: "i" } },
        { category: { $regex: keyword, $options: "i" } },
      ],
    });

    const baseUrl = "http://10.0.2.2:5000";
    const formatProducts = products.map((product) => ({
      ...product._doc,
      images: product.images.map((img) => {
        const cleanPath = img.replace(/\\/g, "/");
        return `${baseUrl}/${cleanPath}`;
      }),
    }));

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

module.exports = { searchHandler };
