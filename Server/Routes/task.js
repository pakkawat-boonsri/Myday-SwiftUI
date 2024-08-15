const express = require("express");
const router = express.Router();
const Activity = require("../models/activity");
const mongoose = require("mongoose");
const User = require("../models/user");
const RSA = require("../RSA")
let rsa = new RSA(73, 89)
router.get("/filter/all/:token&:date&:datetime", async (req, res, next) => {
    try {
        const token = req.params.token
        const user = await User.find({ token: token }, { subject: 0 });
        const date = req.params.date;
        const datetime = req.params.datetime;
        const subjectsort = await User.aggregate([{ $match: { $and: [{ 'token': token }, { 'role': { $not: { $eq: 103 } } }] } },
        { $unwind: '$subject' },
        { $match: { 'subject.date': date } },
        { $sort: { 'subject.date': 1, 'subject.startTime': 1 } },
        { $group: { _id: '$_id', 'subject': { $push: '$subject' } } },
        { $project: { subject: "$subject", _id: 0 } }
        ]);
        const activity = await Activity.aggregate([
            { $addFields: { sDate: { $dateToString: { format: "%Y-%m-%d", date: "$startdate" } }, eDate: { $dateToString: { format: "%Y-%m-%d", date: "$enddate" } } } },
            { $sort: { 'startdate': 1 } }, {
                $project: {
                    name: 1,
                    description: 1,
                    location: 1,
                    sDate: 1,
                    eDate: 1,
                    date: { $dateToString: { format: "%Y-%m-%d %H:%M", date: "$date" } },
                    startdate: { $dateToString: { format: "%Y-%m-%d %H:%M", date: "$startdate" } },
                    enddate: { $dateToString: { format: "%Y-%m-%d %H:%M", date: "$enddate" } },
                }
            }
        ])
        const resultacc = [];
        for (index = 0; index < activity.length; index++) {
            if (datetime >= activity[index].sDate && datetime <= activity[index].eDate) {
                resultacc.push(activity[index])
            }

        }
        for (index = 0; index < resultacc.length; index++) {
            resultacc[index].name = rsa.Decryption(resultacc[index].name)
            resultacc[index].description = rsa.Decryption(resultacc[index].description)
            resultacc[index].location = rsa.Decryption(resultacc[index].location)

            resultacc[index].name = rsa.EncryptionUser(user[0].publickeyN, user[0].publickeyE, resultacc[index].name)
            resultacc[index].description = rsa.EncryptionUser(user[0].publickeyN, user[0].publickeyE, resultacc[index].description)
            resultacc[index].location = rsa.EncryptionUser(user[0].publickeyN, user[0].publickeyE, resultacc[index].location)

        }
        if (typeof subjectsort[0] === 'undefined') {

            const result = { 'subject': [], 'activity': resultacc };

            res.status(200).json({ status: res.statusCode, result: result });
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
            const result = { 'subject': subjectsort[0].subject, 'activity': resultacc };
            res.status(200).json({ status: res.statusCode, result: result });
        }


    } catch {

        res.status(500).json({ status: res.statusCode, message: "Error can't get Data" });
    }
});

router.get("/filter/class/:token&:date", async (req, res, next) => {
    try {
        const token = req.params.token
        const date = req.params.date;
        const user = await User.find({ token: token }, { subject: 0 });
        const subjectsort = await User.aggregate([{ $match: { $and: [{ 'token': token }, { 'role': { $not: { $eq: 103 } } }] } },
        { $unwind: '$subject' },
        { $match: { 'subject.date': date } },
        { $sort: { 'subject.date': 1, 'subject.startTime': 1 } },
        { $group: { _id: '$_id', 'subject': { $push: '$subject' } } },
        { $project: { subject: "$subject" } }
        ]);
        if (typeof subjectsort[0] === 'undefined') {
            const result = { 'subject': [] }
            res.status(200).json({ status: res.statusCode, result: result });
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
            const result = { 'subject': subjectsort[0].subject }
            res.status(200).json({ status: res.statusCode, result: result });
        }

    } catch {
        res.status(500).json({ status: res.statusCode, message: "Error can't get Data" });
    }
});

router.get("/filter/activity/:token&:datetime", async (req, res, next) => {
    try {
        const datetime = req.params.datetime;
        // console.log(Date(datetime))
        const token = req.params.token;
        const user = await User.find({ token: token }, { subject: 0 });
        const activity = await Activity.aggregate([
            { $addFields: { sDate: { $dateToString: { format: "%Y-%m-%d", date: "$startdate" } }, eDate: { $dateToString: { format: "%Y-%m-%d", date: "$enddate" } } } },
            { $sort: { 'startdate': 1 } }, {
                $project: {
                    name: 1,
                    description: 1,
                    location: 1,
                    sDate: 1,
                    eDate: 1,
                    date: { $dateToString: { format: "%Y-%m-%d %H:%M", date: "$date" } },
                    startdate: { $dateToString: { format: "%Y-%m-%d %H:%M", date: "$startdate" } },
                    enddate: { $dateToString: { format: "%Y-%m-%d %H:%M", date: "$enddate" } },
                }
            }
        ])
        const result = [];
        for (index = 0; index < activity.length; index++) {
            if (datetime >= activity[index].sDate && datetime <= activity[index].eDate) {
                result.push(activity[index])
            }

        }
        for (index = 0; index < result.length; index++) {
            result[index].name = rsa.Decryption(result[index].name)
            result[index].description = rsa.Decryption(result[index].description)
            result[index].location = rsa.Decryption(result[index].location)

            result[index].name = rsa.EncryptionUser(user[0].publickeyN, user[0].publickeyE, result[index].name)
            result[index].description = rsa.EncryptionUser(user[0].publickeyN, user[0].publickeyE, result[index].description)
            result[index].location = rsa.EncryptionUser(user[0].publickeyN, user[0].publickeyE, result[index].location)

        }
        res.status(200).json({ status: res.statusCode, result: result });
    } catch {
        res.status(500).json({ status: res.statusCode, message: "Error can't get Data" });
    }
});

module.exports = router;