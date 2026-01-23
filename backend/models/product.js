const mongoose = require('mongoose')

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
        type: String,
        enum: ['electronic', 'fashion'], 
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
        type: Boolean,
        default: true
    },
    soldCount:{
        type: Number,
        default: 0,
    }
})

const product = mongoose.model('Product', productSchema);

module.exports = product;