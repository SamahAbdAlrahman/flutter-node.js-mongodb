const mongoose = require('mongoose');

const videoSchema = new mongoose.Schema({
  exerciseName: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  videoPath: {
    type: String,
    required: true,
  },
});

module.exports = mongoose.model('intermediate', videoSchema);
