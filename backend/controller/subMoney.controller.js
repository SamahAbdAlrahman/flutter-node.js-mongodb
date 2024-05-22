

const bookingService = require('../services/subMoney.service');


async function getProfitByMonth(req, res) {
    try {
      const { month, year } = req.query;
      const profit = await bookingService.calculateProfitByMonth(parseInt(month), parseInt(year));
      res.json({ profit });
    } catch (error) {
      res.status(500).json({ error: 'An error occurred while calculating the profit.' });
    }
  }
  
  module.exports = {
    getProfitByMonth,
  };