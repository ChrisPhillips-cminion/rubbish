const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

// Middleware to parse JSON
app.use(express.json());

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'healthy' });
});

// Main API endpoint that returns origin IP
app.get('/ip', (req, res) => {
  // Get the client IP from various possible headers
  const clientIp = req.headers['x-forwarded-for'] || 
                   req.headers['x-real-ip'] || 
                   req.connection.remoteAddress || 
                   req.socket.remoteAddress ||
                   '129.41.56.3';
  
  res.json({
    origin: clientIp.split(',')[0].trim()
  });
});

// Root endpoint
app.get('/', (req, res) => {
  res.json({
    message: 'Simple Node.js API',
    endpoints: {
      '/': 'This message',
      '/ip': 'Returns origin IP address',
      '/health': 'Health check endpoint'
    }
  });
});

// Start server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server is running on port ${PORT}`);
});

// Made with Bob
