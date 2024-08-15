const mongoose = require("mongoose");

const Schema = mongoose.Schema;
const ObjectId = Schema.ObjectId;

const UserSchema = new Schema({
    id: ObjectId,
    token: String,
    name: String,
    lname: String,
    subject: [
        {
            _id: ObjectId,
            idsubject: String,
            name: String,
            sec:String,
            room: String,
            date: String,
            startTime:String,
            endTime:String,
            lecturer: String,
        },
    ],
    role: Number,
    publickeyN:Number,
    publickeyE:Number,
    image:String
},{ versionKey: false });

const User = mongoose.model("user", UserSchema);

module.exports = User;
