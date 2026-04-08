const Product = require("../models/product");

async function fetchproduct(req, res) {
  try {
    const { id } = req.params;
    if (!id) {
      return res.status(400).json({
        message: "Product ID is required",
      });
    }
    const product = await Product.findById(id);

    if (!product) {
      return res.status(404).json({
        message: "Product not found",
      });
    }
    const baseUrl = "http://10.0.2.2:5000";
    const formatProduct = {
      ...product._doc,
      images: product.images.map((img) => {
        const cleanPath = img.replace(/\\/g, "/");
        return `${baseUrl}/${cleanPath}`;
      }),
    };

    return res.status(200).json({
      message: "success",
      product: formatProduct,
    });
  } catch (e) {
    console.log(e);
    return res.status(500).json({
      message: "server-error",
    });
  }
}

module.exports = { fetchproduct };
