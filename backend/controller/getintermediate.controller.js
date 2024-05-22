// controllers/exerciseController.js
const express = require('express');
const exerciseService = require('../services/getImediate.service');

const router = express.Router();

// Get all exercises
router.get('/', async (req, res) => {
  try {
    const exercises = await exerciseService.getAllExercises();
    res.json(exercises);
  } catch (err) {
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;
