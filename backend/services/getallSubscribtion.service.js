// services/exerciseService.js
const Exercise = require('../model/addsubscribtion.model');

async function getAllExercises() {
  try {
    const exercises = await Exercise.find();
    return exercises;
  } catch (err) {
    throw err;
  }
}

module.exports = {
  getAllExercises,
};
