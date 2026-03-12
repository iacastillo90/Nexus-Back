const jwt = require('jsonwebtoken');

// Get token from command line argument
const token = process.argv[2];

if (!token) {
    console.error('Please provide a token as argument');
    process.exit(1);
}

try {
    const decoded = jwt.decode(token);
    console.log('JWT Payload:');
    console.log(JSON.stringify(decoded, null, 2));
} catch (error) {
    console.error('Error decoding token:', error.message);
    process.exit(1);
}

