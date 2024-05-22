
const express = require('express');
const mealService = require('../services/mealService');

const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const exercises = await mealService.getAllMeals();
    res.json(exercises);
  } catch (err) {
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;
