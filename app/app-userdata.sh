#!/bin/bash
yum update -y
yum install -y nodejs

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
DB_HOST="10.0.21.10"

cat > /home/ec2-user/server.js <<'APPCODE'
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
  res.end(`<h1>3-Tier Architecture Demo</h1><p>Instance: ${INSTANCE_ID}</p><p>DB Host: ${DB_HOST}</p>`);
});

server.listen(80, () => {
  console.log(`App server running on port 80 (Instance: ${INSTANCE_ID})`);
});
APPCODE

export INSTANCE_ID=$INSTANCE_ID
export DB_HOST=$DB_HOST
cd /home/ec2-user
nohup node server.js > app.log 2>&1 &
