const RSA = require("../RSA");
const express = require("express");
const router = express.Router();
const Activity = require("../models/activity");
const mongoose = require("mongoose");
const User = require("../models/user");
// router.get("/", async (req, res, next) => {
//     try {
//         const activity = await Activity.aggregate(
//             [
//                 { "$match": { "enddate": { "$gte": new Date(Date.now()) } } },
//                 { $sort: {'startdate': 1} },
//                 {
//                     $project: {
//                         name: 1,
//                         description: 1,
//                         location: 1,
//                         date: { $dateToString: { format: "%Y-%m-%d %H:%M", date: "$date" } },
//                         startdate: { $dateToString: { format: "%Y-%m-%d %H:%M", date: "$startdate" } },
//                         enddate: { $dateToString: { format: "%Y-%m-%d %H:%M", date: "$enddate" } },

//                     }
//                 }
//             ]
//         );
//         res.status(200).json({ status: res.statusCode, result: activity });
//     } catch {
//         res.status(500).json({ status: res.statusCode, message: "Error can't get Data" });
//     }
// });
router.get("/:token", async (req, res, next) => {
    try {
        const token = req.params.token
        const user = await User.find({ token: token }, { subject: 0 });
        let rsa = new RSA(73, 89)
        const activity = await Activity.aggregate(
            [
                { "$match": { "enddate": { "$gte": new Date(Date.now()) } } },
                { $sort: { 'startdate': 1 } },
                {
                    $project: {
                        name: 1,
                        description: 1,
                        location: 1,
                        date: { $dateToString: { format: "%Y-%m-%d %H:%M", date: "$date" } },
                        startdate: { $dateToString: { format: "%Y-%m-%d %H:%M", date: "$startdate" } },
                        enddate: { $dateToString: { format: "%Y-%m-%d %H:%M", date: "$enddate" } },

                    }
                }
            ]
        );
        for (index = 0; index < activity.length; index++) {
            activity[index].name = rsa.Decryption(activity[index].name)
            activity[index].description = rsa.Decryption(activity[index].description)
            activity[index].location = rsa.Decryption(activity[index].location)

            activity[index].name = rsa.EncryptionUser(user[0].publickeyN, user[0].publickeyE, activity[index].name)
            activity[index].description = rsa.EncryptionUser(user[0].publickeyN, user[0].publickeyE, activity[index].description)
            activity[index].location = rsa.EncryptionUser(user[0].publickeyN, user[0].publickeyE, activity[index].location)
        }
        res.status(200).json({ status: res.statusCode, result: activity });
    } catch {
        res.status(500).json({ status: res.statusCode, message: "Error can't get Data" });
    }
});

// router.get("/calendar/:token", async (req, res, next) => {
//     try {
//         const token = req.params.token
//         const subjectsort = await User.aggregate([{ $match: { 'token': token } },
//         { $unwind: '$subject' },
//         { $sort: { 'subject.date': 1, 'subject.startTime': 1 } },
//         { $group: { _id: '$_id', 'subject': { $push: '$subject' } } },
//         { $project: { subject: "$subject" } }
//         ]);
//         const activity = await Activity.find({});
//         const result = { 'subject': subjectsort[0].subject, 'activity': activity }
//         res.status(200).json({ status: res.statusCode, result: result });
//     } catch {
//         res.status(500).json({ status: res.statusCode, message: "Error can't get Data" });
//     }
// });

router.post("/create", (req, res, next) => {
    const activity_1 = new Activity({
        _id: mongoose.Types.ObjectId(),
        name: req.body.name,
        date: new Date(req.body.date),
        description: req.body.description,
        location: req.body.location,
        startdate: new Date(req.body.startdate + "Z"),
        enddate: new Date(req.body.enddate + "Z")
    });
    activity_1
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
    try {
        const token = req.params.token
        const user = await User.find({ token: token }, { subject: 0 });
        if (user[0].role == 103) {
            const activity_1 = new Activity({
                _id: mongoose.Types.ObjectId(),
                name: req.body.name,
                date: new Date(req.body.date),
                description: req.body.description,
                location: req.body.location,
                startdate: new Date(req.body.startdate + "Z"),
                enddate: new Date(req.body.enddate + "Z")
            });
            activity_1
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
                        message: "Error can't create",
                    });
                });
        } else {
            res.status(401).json({
                status: res.statusCode,
                message: "Not allow to create",
            });
        }
    } catch (error) {
        res.status(500).json({ status: res.statusCode, message: "Error can't create" });
    }
});

router.patch("/update/:id", async (req, res, next) => {
    try {
        const id = req.params.id;
        const updatedData = req.body;
        // console.log(updatedData);
        const options = { new: true };
        const result = await Activity.findByIdAndUpdate(
            id,
            {
                $set: {
                    description: updatedData.description,
                    location: updatedData.location,
                    enddate: new Date(updatedData.enddate + "Z"),
                    startdate: new Date(updatedData.startdate + "Z"),
                    name: updatedData.name,
                    date: new Date(updatedData.date + "Z")
                }
            },
            options
        );

        res.send(result);
        //console.log(result)
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
        // console.log(updatedData);
        const options = { new: true };
        if (user[0].role == 103) {
            const result = await Activity.findByIdAndUpdate(
                id,
                {
                    $set: {
                        description: updatedData.description,
                        location: updatedData.location,
                        enddate: new Date(updatedData.enddate + "Z"),
                        startdate: new Date(updatedData.startdate + "Z"),
                        name: updatedData.name,
                        date: new Date(updatedData.date + "Z")
                    }
                },
                options
            );

            res.send(result);
        } else {
            res.status(401).json({ message: "Not allow to update" });
        }
    } catch (error) {
        res.status(500).json({ status: res.statusCode, message: "Error can't update" });
    }
});
router.delete("/delete/:id", async (req, res, next) => {
    try {
        const id = req.params.id;
        const data = await Activity.findByIdAndDelete(id);
        res.send('Document with ' + data.name + ' has been deleted..');
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
            const data = await Activity.findByIdAndDelete(id);
            res.send('Document with ' + data.name + ' has been deleted..');
        } else {
            res.status(401).json({ message: "Not allow to delete" });
        }
    } catch (error) {
        res.status(500).json({ status: res.statusCode, message: "Error can't delete" });
    }
});

module.exports = router;
