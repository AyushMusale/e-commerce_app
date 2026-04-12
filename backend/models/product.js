const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
    name:{
        type: String,
        required: true
    },
    price: {
        type: Number,
        required: true,
        min: 0
    },
    category: {
        type: [String],
        enum: ["Electronics", "Mobile", "Accessories", "Fashion"], 
        required: true
    },
    images: {
        type: [String],
        required :true
    },
    sellerId: {
        type: Number,
        required: true
    },
    inStock: {
        type: Number,
        default: 10,
        min: 0,
    },
    soldCount:{
        type: Number,
        default: 0,
    }
})


const Product = mongoose.model('Product', productSchema);

module.exports = Product;