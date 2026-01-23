const express = require("express");
const mongoose = require("mongoose");
const product = require("../models/product");

async function addProduct(req, res) {
  try {
    const { name, price, category, inStock, images } = req.body;

    const sellerId = req.user.id;

    if (
      !name ||
      price === undefined ||
      !category ||
      inStock === undefined||
      !images ||
      !Array.isArray(images)
    ) {
      return res.status(400).json({
        status: 400,
        message: "fields-required",
      });
    }

    const newProduct = await product.create({
      name,
      price,
      category,
      sellerId,
      inStock,
      images,
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
