const express = require('express');
const app = express();

const mongoose = require('mongoose');
const cors = require('cors');



mongoose.connect(process.env.DB_CONNECT,)
  .then(() => console.log('DB Connected'))
  .catch(err => console.error('DB connection error:', err));


app.use(express.json());
app.use(cors());
app.use('/api/auth', require('./routes/auth'));
app.use('/api/users', require('./routes/users'));
app.use('/api/tasks', require('./routes/tasks'));



module.exports = app;