// profileService.js
const Profile = require("../model/profile.model");

class ProfileService {
    async searchByUsernameStartsWith(startChar) {
      try {
        const profiles = await Profile.find({ name: { $regex: `^${startChar}`, $options: 'i' } });
        return profiles;
      } catch (error) {
        throw error;
      }
    }
  }
  
  module.exports = new ProfileService();