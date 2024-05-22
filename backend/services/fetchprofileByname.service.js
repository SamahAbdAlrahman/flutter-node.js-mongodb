const Profile = require('../model/profile.model');

class ProfileService {
  // Fetch a profile by username
  async getProfileByUsername(username) {
    try {
      return await Profile.findOne({ username }).exec();
    } catch (error) {
      throw new Error(`Error fetching profile: ${error.message}`);
    }
  }
}

module.exports = new ProfileService();
