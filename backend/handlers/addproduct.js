const product = require("../models/product");

function parseInStock(instock) {
  if (instock === undefined || instock === null || instock === "") {
    return 10;
  }
  let v;
  try {
    v = typeof instock === "string" ? JSON.parse(instock) : instock;
  } catch {
    return 10;
  }
  if (typeof v === "boolean") {
    return v ? 10 : 0;
  }
  const n = Number(v);
  if (!Number.isFinite(n)) {
    return 10;
  }
  return Math.max(0, Math.floor(n));
}

async function addProduct(req, res) {
  try {
    const { name, price, category, instock } = req.body;
    const sellerId = req.user.id;

    const imgPath = req.files.map(file=>file.path);


    if (
      !name ||
      price === undefined ||
      !category
    ) {
      return res.status(400).json({
        status: 400,
        message: "fields-required",
      });
    }

    const newProduct = await product.create({
      name,
      price,
      category: JSON.parse(category),
      sellerId,
      inStock: parseInStock(instock),
      images: imgPath,
    });

    return res.status(201).json({
      status: 201,
      message: "product-added-successfully",
      productId: newProduct._id,
    });
  } catch (e) {
    return res.status(500).json({
      status: 500,
      message: "error",
    });
  }
}

async function UpdateProduct(req, res) {
  const { id } = req.params;
  const { name, price, category, instock} = req.body;
  const sellerId = req.user.id;

  const imgPath = req.files.map(file=>file.path);

  const product = await product.findById(id);
  if (!product) {
    return res.status(404).json({
      message: "product not found",
    });
  }

  product.name = name;
  product.price = price;
  product.category = JSON.parse(category);
  product.inStock = parseInStock(instock);
  product.images = imgPath;
}

module.exports = { addProduct };
