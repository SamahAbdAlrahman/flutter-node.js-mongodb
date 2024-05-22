const mongoose = require('mongoose');

const mealSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    type: {
        type: String,
        enum: ['Breakfast', 'Lunch', 'Dinner'],
        required: true
    },
    calories: {
        type: Number,
        required: true
    },
    protein: {
        type: Number,
        required: true
    },
    carbohydrates: {
        type: Number,
        required: true
    },
    ingredients: {
        type: [String],
        required: true
    },
    recipe_preparation: {
        type: String,
        required: true
    },
    image: {
        type: String,
        required: true
    }
});

const Meal = mongoose.model('Meal', mealSchema);

module.exports = Meal;
