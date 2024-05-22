const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const userWorkout = new mongoose.Schema({
  username: {
    type: Schema.Types.String,
    ref: 'User',
    required: true
  },
  ExcerciseName: String,
  time: Number,
  Calories: Number,
  
  
});

const Booking = mongoose.model('userWorkout', userWorkout);

module.exports = Booking;
