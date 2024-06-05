const http = require('node:http');
var outLine = require('./modules');

const hostname = '0.0.0.0';
const port = 8081;
const server = http.createServer();

server.on("request", function (req, res) {
        inLine = req.url;
        switch (true) {
          case /\/word\/.*/.test(inLine):
            const regex = /^\/word\//;
            let tmpLine = inLine.replace(regex, '')
            res.writeHead(200, {"Content-Type": "test/plain"});
            res.end(outLine.OutputJson(tmpLine));
            break;
          default:
            console.log("not found");
            break;
        }
});

server.listen(port, hostname, () => {
        console.log(`Server running at http://${hostname}:${port}`);
});
