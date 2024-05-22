const ExerciseService = require('../services/deletesubscribtion.service');

class ExerciseController {
  async deleteExercise(req, res) {
    try {
      const exerciseId = req.params.id;
      const exercise = await ExerciseService.deleteExercise(exerciseId);
      if (!exercise) {
        return res.status(404).json({ message: 'Exercise not found' });
      }
      return res.status(204).send({ message: 'delete sucsessful' }); // No content on successful deletion
    } catch (error) {
      return res.status(500).json({ message: 'Failed to delete exercise', error: error.message });
    }
  }
}

module.exports = new ExerciseController();
