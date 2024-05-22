
const Profile = require('../model/profile.model');



async function calculateSalarySum() {
    try {
      const profiles = await Profile.find({});
      let sum = 0;
  
      profiles.forEach((profile) => {
        if (!isNaN(profile.salary)) {
          sum += parseFloat(profile.salary);
        }
      });
  
      return sum;
    } catch (error) {
      throw error;
    }
  }
  
  

module.exports = {
  calculateSalarySum,
};
