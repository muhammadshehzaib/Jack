// db.js
const mysql = require('mysql2');
require('dotenv').config(); // Load environment variables

// Create a pool and enable promises
const pool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'sheh',
    password: process.env.DB_PASSWORD || '123456', // Set to your configuration
    database: process.env.DB_NAME || 'pokemon',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
}).promise();

module.exports = pool;
