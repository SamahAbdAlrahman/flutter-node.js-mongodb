const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const bookingSchema = new mongoose.Schema({
  username: {
    type: Schema.Types.String,
    ref: 'User',
    required: true
  },
  className: String,
  cost: String,
  date: Date,
  time: String,
  coachName: String
});

const Booking = mongoose.model('ClassBooking', bookingSchema);

module.exports = Booking;
