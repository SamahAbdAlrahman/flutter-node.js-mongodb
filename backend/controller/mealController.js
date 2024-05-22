const MealController = require('../services/mealService');

async function addMeal(req, res, next) {
  try {
    const { name, type, calories,protein,carbohydrates,ingredients,recipe_preparation,image } = req.body;
    const MealData = await MealController.createMeal(name, type, calories,protein,carbohydrates,ingredients,recipe_preparation,image);
    res.json({ status: true, success: MealData });

    console.log(req.file);
  console.log(req.body);
  } catch (error) {
    console.error(error);
    next(error);
  }
  
}


module.exports = {
    addMeal,
};
