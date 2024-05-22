const ProfileService = require('../services/fetchprofileByname.service');

class ProfileController {
  // Handle GET request to fetch a profile by username
  async getProfileByUsername(req, res) {
    const { username } = req.params;

    try {
      const profile = await ProfileService.getProfileByUsername(username);
      if (!profile) {
        return res.json({ data: [] });
      } else {
        return res.json({ data: profile });
      }
    } catch (err) {
      return res.json({ err: err });
    }
  }
}

module.exports = new ProfileController();

