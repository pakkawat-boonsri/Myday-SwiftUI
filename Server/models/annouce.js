const mongoose = require("mongoose");

const Schema = mongoose.Schema;
const ObjectId = Schema.ObjectId;

const AnnouceSchema = new Schema({
    id: ObjectId,
    image: String,
    name: String,
    startdate: Date,
    enddate: Date,
},{ versionKey: false });

const Annouce = mongoose.model("annouce", AnnouceSchema);

module.exports = Annouce;
