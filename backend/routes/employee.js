const express = require("express");
const employee = require("../model/employee.model");
const config = require("../configs");
const jwt = require("jsonwebtoken");
let middleware = require("../middleware");
const router = express.Router();
const bcrypt = require('bcrypt'); // Import bcrypt
router.route("/:username").get(middleware.checkToken, (req, res) => {
    Coach.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      username: req.params.username,
    });
  });
});

// router.route("/checkusernameCoach/:username").get(async (req, res) => {
//   try {
//     const result = await Coach.findOne({ username: req.params.username }).exec();

//     if (result !== null) {
//       res.json({
//         Status: true,
//       });
//     } else {
//       res.json({
//         Status: false,
//       });
//     }
//   } catch (err) {
//     res.status(500).json({ msg: err });
//   }
// });
router.route("/login").post(async (req, res) => {
  try {
    const result = await employee.findOne({ username: req.body.username }).exec();

    if (!result) {
      return res.status(403).json("Username incorrect");
    }

    const passwordMatch = await bcrypt.compare(req.body.password, result.password);

    if (passwordMatch) {
      
      const token = jwt.sign({ username: req.body.username }, config.key, {});
      res.json({
        token: token,
        msg: "success",
      });
    } else {
      res.status(403).json("Password is incorrect");
    }
  } catch (err) {
    res.status(500).json({ msg: err });
  }
});


router.route("/register").post(async (req, res) => {
  try {
    console.log("inside the register");
    const { username, password, employeeType } = req.body;

    // Hash the user's password before registration
    const hashedPassword = await bcrypt.hash(password, 10);

    let modifiedUsername = username; // Initialize with the provided username

    if (employeeType === "Coach") {
      modifiedUsername = "119" + username; // Prepend "119" for Coaches
    } else if (employeeType === "Nutritionist") {
      modifiedUsername = "120" + username; // Prepend "120" for Nutritionists
    } else {
      res.status(400).json({ status: false, error: 'Invalid employeeType' });
      return; // Exit early if employeeType is invalid
    }

    const newEmployee = new employee({
      username: modifiedUsername,
      password: hashedPassword,
      employeeType: employeeType,
    });

    await newEmployee.save();
    console.log(`${employeeType} registered`);
    res.status(201).json({ status: true, success: `${employeeType} registered successfully` });
  } catch (err) {
    console.error(err); // Log the error for debugging
    res.status(500).json({ status: false, error: 'Internal Server Error' });
  }
});


// router.route("/updateCoach/:username").patch(async (req, res) => {
//   try {
//     console.log(req.params.username);
//     const result = await Coach.findOneAndUpdate(
//       { username: req.params.username },
//       { $set: { password: req.body.password } },
//       { new: true }
//     ).exec();

//     if (result) {
//       const msg = {
//         msg: "Password successfully updated",
//         username: req.params.username,
//       };
//       return res.json(msg);
//     } else {
//       return res.status(404).json({ msg: "Coach not found" });
//     }
//   } catch (err) {
//     return res.status(500).json({ msg: err.message });
//   }
// });


// router.route("/delete/:username").delete(middleware.checkToken, async (req, res) => {
//   try {
//     const result = await Coach.findOneAndDelete({ username: req.params.username }).exec();

//     if (result) {
//       const msg = {
//         msg: "Coach deleted",
//         username: req.params.username,
//       };
//       return res.json(msg);
//     } else {
//       return res.status(404).json({ msg: "Coach not found" });
//     }
//   } catch (err) {
//     return res.status(500).json({ msg: err.message });
//   }
// });

module.exports = router;
