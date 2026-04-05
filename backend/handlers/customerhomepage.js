const mongoose = require("mongoose");
const product = require("../models/product");
//get carousel from the DB
//get top 5 electronic items from DB, top 5 rated
//get top 5 fashion items from DB, top 5 rated

async function getHomePage(req, res) {
  try {
    const [electronicItems, fashionItems] = await Promise.all([
      product.find({ category: {  $regex: /^electronics$/i } }).limit(5).select('_id name price images').lean(),
      product.find({ category: {  $regex: /^fashion$/i} }).limit(5).select('_id name price images').lean()
    ]);

    const baseUrl = "http://10.0.2.2:5000";
    const formatImages = (items)=>{
      return items.map(item=>({
        ...item,
        images: item.images.map(img=>{
          const cleanPath = img.replace(/\\/g, "/");
          return  `${baseUrl}/${cleanPath}`}),
      }))
    }

    return res.status(200).json({
        message: 'success',
        electronics_items: formatImages(electronicItems),
        fashion_items: formatImages(fashionItems)
    })
  } catch (e) {
    return res.status(500).json({
        message: e.message,
    })
  }
}

module.exports = {getHomePage}