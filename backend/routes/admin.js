const express = require("express");
const Admin = require("../model/admin.model");
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


router.route("/login").post(async (req, res) => {
  try {
    const result = await Admin.findOne({ username: req.body.username }).exec();

    if (!result) {
      return res.status(403).json("Admin incorrect");
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
    const hashedPassword = await bcrypt.hash(password, 10);

    const s = new Admin({
      username,
      password: hashedPassword,
      email,
     
    });

    await s.save();
    console.log("Admin registered");
    res.status(201).json({ status: true, success: 'Admin registered successfully' });
  } catch (err) {
    res.status(500).json({ status: false, error: 'Internal Server Error' });
  }
});

router.route("/update/:username").patch(async (req, res) => {
  try {
    console.log(req.params.username);
    const result = await Admin.findOneAndUpdate(
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



module.exports = router;
