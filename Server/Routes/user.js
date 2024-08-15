const express = require("express");
const router = express.Router();
const User = require("../models/user");
const mongoose = require("mongoose");
const RSA = require("../RSA");
let rsa = new RSA(73, 89)
router.get("/:token", async (req, res, next) => {
  try {
    const token = req.params.token
    const user = await User.find({ token: token }, { subject: 0 });
    
    res.status(200).json({ status: res.statusCode, result: user[0] });
  } catch {
    res.status(500).json({ message: "Error can't get Data" });
  }
});

router.get("/getkey/:token", async (req, res, next) => {
  try {
    const token = req.params.token
    const user = await User.find({ token: token }, { subject: 0 ,name:0,lname:0,role:0,_id:0,token:0});
    const N= rsa.getPublicKeyN()
    const E= rsa.getPublicKeyE()
    res.status(200).json({ N,E });
  } catch {
    res.status(500).json({ message: "Error can't get Data" });
  }
});

router.post("/adduser", (req, res, next) => {
  const user_1 = new User({
    _id: mongoose.Types.ObjectId(),
    token: req.body.token,
    name: req.body.name,
    lname: req.body.lname,
    subject: req.body.subject,
    role: req.body.role,
    publickeyN: req.body.publickeyN,
    publickeyE: req.body.publickeyE,
    image:req.body.image
  });
  user_1
    .save()
    .then((result) => {
      console.log(result);
      res.status(200).json({
        message: result,
      });
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({
        message: err,
      });
    });
});

router.patch("/update/:id", async (req, res, next) => {
  try {
    const id = req.params.id;
    const updatedData = req.body;
    const options = { new: true };

    const result = await User.findByIdAndUpdate(
      id,
      { $set: updatedData },
      options
    );

    res.send(result);
  } catch (error) {
    res.status(500).json({ message: "Error can't update" });
  }
});
router.patch("/updatekey/:token/:keyN&:keyE", async (req, res, next) => {
  try {
    const token = req.params.token
    const keyN = req.params.keyN
    const keyE = req.params.keyE
    const options = { new: true };

    const result = await User.findOneAndUpdate(
      { "token": token },
      { $set:  {"publickeyN":keyN,"publickeyE":keyE}},
      options
    );

    res.send(result);
  } catch (error) {
    res.status(500).json({ message: "Error can't update" });
  }
});
router.delete("/delete/:id", async (req, res, next) => {
  try {
    const id = req.params.id;
    const data = await User.findByIdAndDelete(id);
    res.send("Document with " + data.name + " has been deleted..");
  } catch (error) {
    res.status(500).json({ message: "Error can't delete" });
  }
});

module.exports = router;
