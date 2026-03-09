const http = require('http');

const INSTANCE_ID = process.env.INSTANCE_ID || 'unknown';
const DB_HOST = process.env.DB_HOST || '10.0.21.10';

function queryDatabase() {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        users: 42,
        posts: 156,
        lastUpdate: new Date().toISOString()
      });
    }, 100);
  });
}

const server = http.createServer(async (req, res) => {
  if (req.url === '/health') {
    res.writeHead(200, {'Content-Type': 'application/json'});
    res.end(JSON.stringify({ status: 'healthy', instance: INSTANCE_ID }));
    return;
  }

  if (req.url === '/api/stats') {
    const dbData = await queryDatabase();
    res.writeHead(200, {'Content-Type': 'application/json'});
    res.end(JSON.stringify({
      instance: INSTANCE_ID,
      database: DB_HOST,
      data: dbData
    }));
    return;
  }

  const dbData = await queryDatabase();
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.end(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>3-Tier Application</title>
    </head>
    <body style="font-family: Arial; padding: 40px;">
      <h1>3-Tier Architecture Demo</h1>
      <p><strong>Tier 1:</strong> Application Load Balancer</p>
      <p><strong>Tier 2 Instance:</strong> ${INSTANCE_ID}</p>
      <p><strong>Tier 3 Database Host:</strong> ${DB_HOST}</p>
      <p><strong>Total Users:</strong> ${dbData.users}</p>
      <p><strong>Total Posts:</strong> ${dbData.posts}</p>
      <p><strong>Last Update:</strong> ${dbData.lastUpdate}</p>
    </body>
    </html>
  `);
});

server.listen(80, () => {
  console.log(`App server running on port 80 (Instance: ${INSTANCE_ID})`);
});
