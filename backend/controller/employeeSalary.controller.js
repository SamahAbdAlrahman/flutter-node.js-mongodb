
const profileService = require('../services/empolyeeSalary.service');


async function getSalarySum(req, res) {
    try {
      const sum = await profileService.calculateSalarySum();
      res.json({ sum });
    } catch (error) {
      res.status(500).json({ error: 'An error occurred while calculating salary sum.' });
    }
  }
  
 
module.exports = {
  getSalarySum
};
