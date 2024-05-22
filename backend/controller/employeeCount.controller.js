

const userService = require('../services/employeeCount.service');

async function getUsersCount(req, res) {
  try {
    const count = await userService.getUsersCount();
    res.json({ count });
  } catch (error) {
    res.status(500).json({ error: 'An error occurred while fetching user count.' });
  }
}

module.exports = {
  getUsersCount,
};
