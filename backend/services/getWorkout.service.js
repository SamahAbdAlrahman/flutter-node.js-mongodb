// services/userWorkoutService.js
const UserWorkout = require('../model/userWorkout.model');

class UserWorkoutService {
  async getExerciseCount(username) {
    try {
      const count = await UserWorkout.countDocuments({ username });
      return count;
    } catch (error) {
      throw error;
    }
  }

  async getSumOfTime(username) {
    try {
      const workouts = await UserWorkout.find({ username });
      const sumOfTime = workouts.reduce((sum, workout) => sum + workout.time, 0);
      return sumOfTime;
    } catch (error) {
      throw error;
    }
  }
  async getSumOfCalories(username) {
    try {
      const workouts = await UserWorkout.find({ username });
      const sumOfTime = workouts.reduce((sum, workout) => sum + workout.Calories, 0);
      return sumOfTime;
    } catch (error) {
      throw error;
    }
  }
}



  
module.exports = new UserWorkoutService();
