// profileController.js
const profileService = require("../services/SearchByName.service");
// controllers/profileController.js

class ProfileController {
  async searchByUsernameStartsWith(req, res) {
    try {
      const startChar = req.query.startChar;
      const profiles = await profileService.searchByUsernameStartsWith(startChar);
      res.json(profiles);
    } catch (error) {
      res.status(500).json({ error: 'An error occurred while searching for profiles.' });
    }
  }
}

module.exports = new ProfileController();
