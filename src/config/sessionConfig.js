const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session);
const pool = require('./db'); // Ensure you have a pool export from your database module
require('dotenv').config(); // Load environment variables
// Options for MySQL store
const sessionStoreOptions = {
    clearExpired: true,
    checkExpirationInterval: 900000, // 15 minutes
    expiration: 86400000, // 1 day
    createDatabaseTable: true
};

// Create the MySQL store
const sessionStore = new MySQLStore(sessionStoreOptions, pool);

// Configure the session middleware
const sessionMiddleware = session({
    key: process.env.SESSION_COOKIE_NAME || 'session_cookie_name',
    secret: process.env.SESSION_SECRET || 'default_secret_key',
    store: sessionStore,
    resave: false,
    saveUninitialized: false,
    cookie: {
        secure: false, // Set to true if using HTTPS
        maxAge: 86400000 // 1 day
    }
});

module.exports = sessionMiddleware;
