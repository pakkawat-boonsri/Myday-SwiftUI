const express = require("express");
const app = express();
const morgan = require("morgan");
const mongoose = require("mongoose");
const config = require("config");

const rateLimit = require("express-rate-limit");

const limiter = rateLimit({
	windowMs: 15 * 60 * 1000, 
	max: 200, 
    standardHeaders: false,
    legacyHeaders: false,
    message: "Too many request from this IP"
})

const userRouter = require("./Routes/user");
const annouceRouter = require("./Routes/annouce");
const activityRouter = require("./Routes/activity");
const taskRouter =require("./Routes/task");
const subjectRouter =require('./Routes/subject');
const calendarRouter =require('./Routes/calendar');
const helmet = require("helmet");
const dbConfig = config.get("MyDay.dbConfig.dbName");
mongoose
    .connect(dbConfig, {
        useNewUrlParser: true,
        useUnifiedTopology: true,
    })
    .then(() => {
        console.log("Database Connected");
    })
    .catch((err) => {
        console.log("Database not Connected + " + err);
    });
app.use(limiter)
app.use(helmet());
app.use(morgan("dev"));
app.use(express.json());
////////////////////add router//////////////////
app.use("/user", userRouter);
app.use("/annouce", annouceRouter);
app.use("/activity", activityRouter);
app.use("/task",taskRouter);
app.use("/subject",subjectRouter);
app.use("/calendar",calendarRouter);
//////////////////////////////////////////////
app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header(
        "Access-Control-Allow-Headers",
        "Origin,X-Requested-With,Content-Type,Accept,Authorization"
    );

    if (req.method === "OPTIONS") {
        res.header("Accept-Control-Methods", "PUT,POST,PATCH,DELETE,GET");
        return res.status(200).json({});
    }
    next();
});

app.use((req, res, next) => {
    const error = new Error("Not Found");
    next(error);
});

app.use((error, req, res, next) => {
    res.status(error.status || 500);
    res.json({
        error: {
            message: error.message,
        },
    });
});

module.exports = app;
