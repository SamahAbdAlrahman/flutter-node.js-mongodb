// controllers/userWorkoutController.js
const userWorkoutService = require('../services/getWorkout.service');
const User = require('../model/users.model'); // Import the User model

class UserWorkoutController {
  async getExerciseCount(req, res) {
   // const { username } = req.user; // Assuming you have middleware to extract the user from the token
    try {
        console.log('Decoded Token:', req.decoded);

        // Get the username from the decoded token (assuming you have a middleware for authentication)
        const username = req.decoded.username;
  
        // Find the user in the database to get their ObjectId
        const user = await User.findOne({ username });
  
        if (!user) {
          return res.status(404).json({ error: 'User not found' });
        }
      const count = await userWorkoutService.getExerciseCount(username);
      res.json({ count });
      console.log(count);

    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  }

  async getSumOfTime(req, res) {
    const { username } = req.params;
    try {

        const username = req.decoded.username;
  
        // Find the user in the database to get their ObjectId
        const user = await User.findOne({ username });
  
        if (!user) {
          return res.status(404).json({ error: 'User not found' });
        }
      const sumOfTime = await userWorkoutService.getSumOfTime(username);
      res.status(200).json({ sumOfTime });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  async getSumOfCalories(req, res) {
    const { username } = req.params;
    try {

        const username = req.decoded.username;
  
        // Find the user in the database to get their ObjectId
        const user = await User.findOne({ username });
  
        if (!user) {
          return res.status(404).json({ error: 'User not found' });
        }
      const sumOfcalories = await userWorkoutService.getSumOfCalories(username);
      res.status(200).json({ sumOfcalories });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
} 



module.exports = new UserWorkoutController();
