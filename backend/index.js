require("dotenv").config();
const express = require("express");
const auth_router = require("./routes/auth");
const seller_router = require("./routes/seller");
const customer_router = require("./routes/customer");
const { jwtAuth } = require("./middleware/jwtAuth");
const path = require("path");
const mongoose = require("mongoose");
const Product = require("./models/product");

const app = express();
const port = 5000;

//  One-time migration: set every product's inStock to 10. Set RUN_INSTOCK_MIGRATION=true once, restart server, then unset.
// async function migrateAllProductsInStockToTen() {
//   const result = await Product.updateMany({}, { $set: { inStock: 10 } });
//   console.log(
//     `migrateAllProductsInStockToTen: matched ${result.matchedCount}, modified ${result.modifiedCount}`,
//   );
// }

mongoose
  .connect(process.env.MONGODB_URI)
  .then(async () => {
    console.log("MongoServer started");
    // if (process.env.RUN_INSTOCK_MIGRATION === "true") {
    //   try {
    //     await migrateAllProductsInStockToTen();
    //   } catch (e) {
    //     console.error("migrateAllProductsInStockToTen failed:", e);
    //   }
    // }
  })
  .catch((err) => {
    console.log(err);
  });

app.use(express.json());
app.use("/uploads", express.static(path.join(__dirname, "../uploads")));
app.use("/api/ECAPP/auth", auth_router);
app.use("/api/ECAPP/seller", jwtAuth, seller_router);
app.use("/api/ECAPP/customer", customer_router);
app.post("/api/ECAPP/test", jwtAuth, (req, res) => {
  return res.json({
    status: "working",
  });
});

app.listen(port, () => {
  console.log("sever started");
});
