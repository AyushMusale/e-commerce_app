const express = require("express");
const mongoose = require("mongoose");
const product = require("../models/product");


async function addProduct(req, res) {
  try {
    const { name, price, category, instock} = req.body;
    const sellerId = req.user.id;

    const imgPath = req.files.map(file=>file.path);


    if (
      !name ||
      price === undefined ||
      !category ||
      instock === undefined
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
      inStock: JSON.parse(instock),
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

module.exports = { addProduct };
