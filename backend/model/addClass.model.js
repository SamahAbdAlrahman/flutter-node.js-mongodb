const mongoose = require('mongoose');

const ClassSchema = new mongoose.Schema({
  imagePath: {
    type: String,
    required: true,
  },
  ClassName: {
    type: String,
    required: true,
  },
  time: {
    type: String,
    required: true,
  },
  Date: {
    type: String,
    required: true,
  },
  cost: {
    type: String,
    required: true,
  },
  cotchName: {
    type: String,
    required: true,
  },
  allowedNumber: {
    type: Number,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
});

module.exports = mongoose.model('AddClass', ClassSchema);
