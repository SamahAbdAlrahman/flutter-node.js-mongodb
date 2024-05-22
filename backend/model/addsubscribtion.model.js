const mongoose = require('mongoose');

const sub = new mongoose.Schema({
  price: {
    type: String,
    required: true,
  },
  month: {
    type: String,
    required: true,
  },
  
});

module.exports = mongoose.model('subscribtion', sub);
