const express = require("express");
const router = express.Router();
const Activity = require("../models/activity");
const mongoose = require("mongoose");
const RSA = require("../RSA");

router.get("/:year/:month", async (req, res, next) => {
    try {
        const qyear = req.params.year;
        const qmonth = req.params.month;
        const activity = await Activity.aggregate([
            // { $addFields: { "month": { $month: "$startdate" } ,"year":{ $year: "$startdate" } }, },
            // { $match: {$and: [{"month":parseInt(qmonth)},{"year":parseInt(qyear)}] } },
            // { $group: { _id: { $dayOfMonth: '$startdate' } } },
            {
                $project: {
                    _id: 0,
                    // day: "$_id",
                    startdate:{ $dateToString: { format: "%Y-%m-%d", date: "$startdate" } },
                    enddate: { $dateToString: { format: "%Y-%m-%d", date: "$enddate" } }
                }
            },
            { $sort: { 'day': 1 } },
        ])
        const dates = [];
        for(index = 0 ;index<activity.length;index++)
        {
            const d1 = new Date(activity[index].startdate)
            const d2 = new Date(activity[index].enddate)
            const date = new Date(d1.getTime());
      
            while (date <= d2) {
                dates.push(new Date(date).toLocaleDateString());
                date.setDate(date.getDate() + 1);
        }
        //console.log(dates)
        }
            
        res.status(200).json({ status: res.statusCode, result: dates });
    } catch {
        res.status(500).json({ status: res.statusCode, message: "Error can't get Data" });
    }
});


module.exports = router;
