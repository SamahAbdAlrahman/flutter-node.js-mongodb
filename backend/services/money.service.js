
const Booking = require('../model/classBooking.model');

async function calculateProfitByMonth(month, year) {
  try {
    const startDate = new Date(year, month - 1, 1); // month is 0-indexed
    const endDate = new Date(year, month, 0);

    const bookings = await Booking.find({
      date: { $gte: startDate, $lte: endDate },
    });

    const totalProfit = bookings.reduce((acc, booking) => acc + parseFloat(booking.cost), 0);

    return totalProfit;
  } catch (error) {
    throw error;
  }
}

module.exports = {
  calculateProfitByMonth,
};
