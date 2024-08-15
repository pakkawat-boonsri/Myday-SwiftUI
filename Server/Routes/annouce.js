const RSA = require("../RSA");
const express = require("express");
const router = express.Router();
const Annouce = require("../models/annouce");
const User = require("../models/user");
const mongoose = require("mongoose");
let rsa = new RSA(73, 89)
// router.get("/", async (req, res, next) => {
//   try {
//     const annouce = await Annouce.aggregate(
//       [
//           {
//               $project: {
//                   name:1,
//                   image:1,
//                   startdate:{ $dateToString: { format: "%Y-%m-%d %H:%M", date: "$startdate" } },
//                   enddate:{ $dateToString: { format: "%Y-%m-%d %H:%M", date: "$enddate" } },

//               }
//           }
//       ]
//   );
//     res.status(200).json({ status: res.statusCode, result: annouce });
//   } catch {
//     res.status(500).json({ status: res.statusCode, message: "Error can't get Data" });
//   }
// });

router.get("/:token", async (req, res, next) => {
  try {
    const token = req.params.token
    const user = await User.find({ token: token }, { subject: 0 });
    const annouce = await Annouce.aggregate(
      [
        {
          $project: {
            name: 1,
            image: 1,
            startdate: { $dateToString: { format: "%Y-%m-%d %H:%M", date: "$startdate" } },
            enddate: { $dateToString: { format: "%Y-%m-%d %H:%M", date: "$enddate" } },

          }
        }
      ]
    );
    for (index = 0; index < annouce.length; index++) {
      annouce[index].name = rsa.Decryption(annouce[index].name)
      annouce[index].image = rsa.Decryption(annouce[index].image)

      annouce[index].name = rsa.EncryptionUser(user[0].publickeyN, user[0].publickeyE, annouce[index].name)
      annouce[index].image = rsa.EncryptionUser(user[0].publickeyN, user[0].publickeyE, annouce[index].image)
    }
    res.status(200).json({ status: res.statusCode, result: annouce });
  } catch {
    res.status(500).json({ status: res.statusCode, message: "Error can't get Data" });
  }
});


// router.get("/pageannouce/:token", async (req, res, next) => {
//   try {
//     const token = req.params.token
//     const subjectsort = await User.aggregate([{ $match: { 'token': token } },
//     { $unwind: '$subject' },
//     { $sort: { 'subject.date': 1, 'subject.startTime': 1 } },
//     { $group: { _id: '$_id', 'subject': { $push: '$subject' } } },
//     { $project: { subject: "$subject" } }
//     ]);
//     const annouce = await Annouce.find({});
//     const result = { 'subject': subjectsort[0].subject, 'annouce': annouce }
//     res.status(200).json({ status: res.statusCode, result: result });
//   } catch {
//     res.status(500).json({ status: res.statusCode, message: "Error can't get Data" });
//   }
// });

router.post("/create", (req, res, next) => {
  const annouce_1 = new Annouce({
    _id: mongoose.Types.ObjectId(),
    image: req.body.image,
    name: req.body.name,
    startdate: new Date(req.body.startdate + "Z"),
    enddate: new Date(req.body.enddate + "Z"),
  });
  annouce_1
    .save()
    .then((result) => {
      console.log(result);
      res.status(200).json({
        status: res.statusCode,
        message: result,
      });
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({
        status: res.statusCode,
        message: err,
      });
    });
});
router.post("/create/:token", async (req, res, next) => {
  const token = req.params.token
  const user = await User.find({ token: token }, { subject: 0 });
  if (user[0].role == 103) {
    const annouce_1 = new Annouce({
      _id: mongoose.Types.ObjectId(),
      image: req.body.image,
      name: req.body.name,
      startdate: new Date(req.body.startdate + "Z"),
      enddate: new Date(req.body.enddate + "Z"),
    });
    annouce_1
      .save()
      .then((result) => {
        console.log(result);
        res.status(200).json({
          status: res.statusCode,
          message: result,
        });
      })
      .catch((err) => {
        console.log(err);
        res.status(500).json({
          status: res.statusCode,
          message: err,
        });
      });
  }else{
    res.status(401).json({
      status: res.statusCode,
      message: "Not allow to create",
    });
  }

});

router.patch("/update/:id", async (req, res, next) => {
  try {
    const id = req.params.id;
    const updatedData = req.body;
    const options = { new: true };

    const result = await Annouce.findByIdAndUpdate(
      id,
      {
        $set: {
          image: updatedData.image,
          name: updatedData.name,
          enddate: new Date(updatedData.enddate + "Z"),
          startdate: new Date(updatedData.startdate + "Z"),
        }
      },
      options
    );

    res.send(result);
  } catch (error) {
    res.status(500).json({ status: res.statusCode, message: "Error can't update" });
  }
});

router.patch("/update/:token/:id", async (req, res, next) => {
  try {
    const token = req.params.token
    const user = await User.find({ token: token }, { subject: 0 });
    const id = req.params.id;
    const updatedData = req.body;
    const options = { new: true };
    if (user[0].role == 103) {
    const result = await Annouce.findByIdAndUpdate(
      id,
      {
        $set: {
          image: updatedData.image,
          name: updatedData.name,
          enddate: new Date(updatedData.enddate + "Z"),
          startdate: new Date(updatedData.startdate + "Z"),
        }
      },
      options
    );
      res.send(result);
    }else{
      res.status(401).json({ status: res.statusCode, message: "Not allow to update" });
    }
    
  } catch (error) {
    res.status(500).json({ status: res.statusCode, message: "Error can't update" });
  }
});

router.delete("/delete/:id", async (req, res, next) => {
  try {
    const id = req.params.id;
    const data = await Annouce.findByIdAndDelete(id);
    res.send("Document with " + data.name + " has been deleted..");
  } catch (error) {
    res.status(500).json({ status: res.statusCode, message: "Error can't delete" });
  }
});

router.delete("/delete/:token/:id", async (req, res, next) => {
  try {
    const token = req.params.token
    const user = await User.find({ token: token }, { subject: 0 });
    const id = req.params.id;
    if (user[0].role == 103) {
    const data = await Annouce.findByIdAndDelete(id);
    res.send("Document with " + data.name + " has been deleted..");
    }else{
      res.status(401).json({  message: "Not allow to delete" });
    }
  } catch (error) {
    res.status(500).json({ status: res.statusCode, message: "Error can't delete" });
  }
});

module.exports = router;
