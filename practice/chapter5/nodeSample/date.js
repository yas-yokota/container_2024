process.env.TZ = 'Asia/Tokyo';

const http = require('node:http');
var dateTime = require('./modules');

const hostname = '0.0.0.0';
const port = 8081;

const server = http.createServer((req, res) => {
	res.statusCode = 200;
	res.setHeader('Content-Type','test/plain');
	res.end('Current time: ' + dateTime.CurrentDateTime());
});

server.listen(port, hostname, () => {
	console.log(`Server running at http://${hostname}:${port}`);
});

