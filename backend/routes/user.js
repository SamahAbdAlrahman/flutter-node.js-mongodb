const express = require("express");
const User = require("../model/users.model");
const config = require("../configs");
const jwt = require("jsonwebtoken");
let middleware = require("../middleware");
const router = express.Router();
const bcrypt = require('bcrypt'); // Import bcrypt
router.route("/:username").get(middleware.checkToken, (req, res) => {
  User.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      username: req.params.username,
    });
  });
});

router.route("/checkusername/:username").get(async (req, res) => {
  try {
    const result = await User.findOne({ username: req.params.username }).exec();

    if (result !== null) {
      res.json({
        Status: true,
      });
    } else {
      res.json({
        Status: false,
      });
    }
  } catch (err) {
    res.status(500).json({ msg: err });
  }
});

// router.route("/login").post((req, res) => {
//   User.findOne({ username: req.body.username }, (err, result) => {
//     if (err) return res.status(500).json({ msg: err });
//     if (result === null) {
//       return res.status(403).json("Username incorrect");
//     }
//     if (result.password === req.body.password) {
//       // here we implement the JWT token functionality
//       let token = jwt.sign({ username: req.body.username }, config.key, {});

//       res.json({
//         token: token,
//         msg: "success",
//       });
//     } else {
//       res.status(403).json("password is incorrect");
//     }
//   });
// });

router.route("/login").post(async (req, res) => {
  try {
    const result = await User.findOne({ username: req.body.username }).exec();

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
    const { username, password, email } = req.body;

    // Hash the user's password before registration
    const hashedPassword = await bcrypt.hash(password, 10);

    const user = new User({
      username,
      password: hashedPassword,
      email,
     
    });

    await user.save();
    console.log("user registered");
    res.status(201).json({ status: true, success: 'User registered successfully' });
  } catch (err) {
    res.status(500).json({ status: false, error: 'Internal Server Error' });
  }
});

router.route("/update/:username").patch(async (req, res) => {
  try {
    console.log(req.params.username);
    const result = await User.findOneAndUpdate(
      { username: req.params.username },
      { $set: { password: req.body.password } },
      { new: true }
    ).exec();

    if (result) {
      const msg = {
        msg: "Password successfully updated",
        username: req.params.username,
      };
      return res.json(msg);
    } else {
      return res.status(404).json({ msg: "User not found" });
    }
  } catch (err) {
    return res.status(500).json({ msg: err.message });
  }
});


router.route("/delete/:username").delete(middleware.checkToken, async (req, res) => {
  try {
    const result = await User.findOneAndDelete({ username: req.params.username }).exec();

    if (result) {
      const msg = {
        msg: "User deleted",
        username: req.params.username,
      };
      return res.json(msg);
    } else {
      return res.status(404).json({ msg: "User not found" });
    }
  } catch (err) {
    return res.status(500).json({ msg: err.message });
  }
});




module.exports = router;