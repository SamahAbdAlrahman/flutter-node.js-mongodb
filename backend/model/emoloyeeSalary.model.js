const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const Profile = Schema(
  {
    username: {
      type: String,
      required: true,
      unique: true,
    },
    name: String,
    profession: String,
    salary:String,
    img: {
      type: String,
      default: "",
    },
  },
  {
    timestamp: true,
  }
);

module.exports = mongoose.model("salary", Profile);
