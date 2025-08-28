const express = require('express');
const app = express();

const mongoose = require('mongoose');


mongoose.connect(process.env.DB_CONNECT,)
  .then(() => console.log('DB Connected'))
  .catch(err => console.error('DB connection error:', err));



module.exports = app;