const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const employee = new Schema({
  username: {
    type: Number,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  employeeType: {
    type: String,
    enum: ["Coach", "Nutritionist"],
    required: true,
  },
});

module.exports = mongoose.model("employee", employee);
