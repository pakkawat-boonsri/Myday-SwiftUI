const mongoose = require("mongoose");

const Schema = mongoose.Schema;
const ObjectId = Schema.ObjectId;

const ActivitySchema = new Schema({
    id: ObjectId,
    name: String,
    date: Date,
    description: String,
    location:String,
    startdate:Date,
    enddate:Date
},{ versionKey: false });

const User = mongoose.model("activity", ActivitySchema);

module.exports = User;
