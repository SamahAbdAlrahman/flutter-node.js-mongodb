
const User = require('../model/employee.model');

async function getUsersCount() {
  try {
    const count = await User.countDocuments();
    return count;
  } catch (error) {
    throw error;
  }
}

module.exports = {
  getUsersCount,
};
