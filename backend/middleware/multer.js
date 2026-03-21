const multer = require('multer')
const path = require('path')


const storage = multer.diskStorage({
    destination:function(req,files,cb){
        cb(null,'../uploads')
    },
    filename: function(req,file,cb){
        const uniqueName = Date.now().toString();
        cb(null, uniqueName);
    }
});

const upload = multer({storage});

module.exports = upload;