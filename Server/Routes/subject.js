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
    const subjectsort = await User.aggregate([{ $match: { 'token': token } },
    { $unwind: '$subject' },
    { $sort: { 'subject.date': 1, 'subject.startTime': 1 } },
    { $group: { _id: '$_id', 'subject': { $push: '$subject' } } },
    { $project: { subject: "$subject" } }
    ]);
    if (typeof subjectsort[0] === 'undefined') {
      const subject = []
      res.status(200).json({ status: res.statusCode, result: subject });
    } else {
      for (index = 0; index < subjectsort[0].subject.length; index++) {
        subjectsort[0].subject[index].idsubject = rsa.Decryption(subjectsort[0].subject[index].idsubject)
        subjectsort[0].subject[index].name = rsa.Decryption(subjectsort[0].subject[index].name)
        subjectsort[0].subject[index].room = rsa.Decryption(subjectsort[0].subject[index].room)
        subjectsort[0].subject[index].sec = rsa.Decryption(subjectsort[0].subject[index].sec)
        subjectsort[0].subject[index].lecturer = rsa.Decryption(subjectsort[0].subject[index].lecturer)

        subjectsort[0].subject[index].idsubject = rsa.EncryptionUser(user[0].publickeyN, user[0].publickeyE, subjectsort[0].subject[index].idsubject)
        subjectsort[0].subject[index].name = rsa.EncryptionUser(user[0].publickeyN, user[0].publickeyE, subjectsort[0].subject[index].name)
        subjectsort[0].subject[index].room = rsa.EncryptionUser(user[0].publickeyN, user[0].publickeyE, subjectsort[0].subject[index].room)
        subjectsort[0].subject[index].sec = rsa.EncryptionUser(user[0].publickeyN, user[0].publickeyE, subjectsort[0].subject[index].sec)
        subjectsort[0].subject[index].lecturer = rsa.EncryptionUser(user[0].publickeyN, user[0].publickeyE, subjectsort[0].subject[index].lecturer)
      }
      res.status(200).json({ status: res.statusCode, result: subjectsort[0].subject });
    }
    // const subject = subjectsort[0].subject;
    // //console.log(subject);
    // res.status(200).json({ status: res.statusCode, result: subject });
  } catch {
    res.status(500).json({ message: "Error can't get Data" });
  }
});

module.exports = router;
