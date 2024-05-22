/////////////////////
const express = require('express');
const router = express.Router();
const mealController = require('../controller/mealController');
router.post('/addMeal', mealController.addMeal);
const getmealController = require('../controller/getMeals.controller');

//////////////////////////

module.exports = router;
