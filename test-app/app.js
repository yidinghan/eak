require('elastic-apm-node').start({
    appName: 'test-app',
    serverUrl: 'http://45.32.87.19:8200',
    logLevel: 'debug'
});
const http = require('http');

const name = 'node-hello-world';
const port = '8888';

const app = new http.Server();

app.on('request', (req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.write('Hello World');
    res.end('\n');
});

app.listen(port, () => {
    console.log(`${name} is listening on port ${port}`);
});
