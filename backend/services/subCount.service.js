
const User = require('../model/subscribtion.model');

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
