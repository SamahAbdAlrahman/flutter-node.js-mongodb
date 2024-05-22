const Meal = require('../model/mealModel');
async function createMeal(name, type, calories,protein,carbohydrates,ingredients,recipe_preparation,image) {
  const newMeal = new Meal({
     name, 
     type,
     calories,
     protein,
     carbohydrates,
     ingredients,
     recipe_preparation,
     image
  });

  return newMeal.save();
}
async function getAllMeals() {
    try {
      const meal = await Meal.find();
      return meal;
    } catch (err) {
      throw err;
    }
  }
module.exports = {
    createMeal,
    getAllMeals
};

