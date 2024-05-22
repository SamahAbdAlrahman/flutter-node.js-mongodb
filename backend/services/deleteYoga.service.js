const Exercise = require('../model/yoga.model');

class ExerciseService {
  async deleteExercise(exerciseId) {
    try {
      const exercise = await Exercise.findByIdAndDelete(exerciseId);
      return exercise;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = new ExerciseService();
