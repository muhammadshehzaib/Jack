const mysql = require('mysql2');

// Create a connection to the database
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'thejungle', // Set password if there's one
  database: 'pokemon'
});

// Connect to the database
connection.connect(err => {
  if (err) {
    console.error('Error connecting to the database:', err);
    return;
  }
  console.log('Successfully connected to the database.');
});

// Query to select all members
const query = 'SELECT * FROM members';

// Execute the query
connection.query(query, (err, results) => {
  if (err) {
    console.error('Error executing the query:', err);
    return;
  }
  if (results.length > 0) {
    console.log('Members list:');
    results.forEach(member => {
      console.log(`ID: ${member.MemberID}, Name: ${member.Name}, Email: ${member.Email}`);
    });
  } else {
    console.log('No members found.');
  }
});

// Close the connection
connection.end(err => {
  if (err) {
    console.error('Error closing the connection:', err);
  } else {
    console.log('Connection closed.');
  }
});
