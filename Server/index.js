const http = require("http");
const app = require("./app");
const port = 4455 || process.env.port;

const server = http.createServer(app);
server.listen(port);
console.log("server is running");
