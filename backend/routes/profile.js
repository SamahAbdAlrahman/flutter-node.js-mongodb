const express = require("express");
const router = express.Router();
const Profile = require("../model/profile.model");

const middleware = require("../middleware");
const multer = require("multer");
const path = require("path");
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./uploads");
  },
  filename: (req, file, cb) => {
    cb(null, req.decoded.username + ".jpg");
  },
});

const fileFilter = (req, file, cb) => {
  if (file.mimetype == "image/jpeg" || file.mimetype == "image/png") {
    cb(null, true);
  } else {
    cb(null, false);
  }
};

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 6,
  },
  // fileFilter: fileFilter,
});

//adding and update profile image
router.route("/add/image").patch(middleware.checkToken, upload.single("img"), async (req, res) => {
  try {
    const profile = await Profile.findOneAndUpdate(
      { username: req.decoded.username },
      {
        $set: {
          img: req.file.path,
        },
      },
      { new: true }
    );

    if (!profile) {
      return res.status(404).json({ message: "Profile not found" });
    }

    const response = {
      message: "Image added and profile updated successfully",
      data: profile,
    };

    return res.status(200).json(response);
  } catch (err) {
    return res.status(500).json({ message: err.message });
  }
});


router.route("/add").post(middleware.checkToken, (req, res) => {
  const profile = Profile({
    username: req.decoded.username,
    name: req.body.name,
    profession: req.body.profession,
    DOB: req.body.DOB,
    titleline: req.body.titleline,
    about: req.body.about,
    salary:req.body.salary
  });
  profile
    .save()
    .then(() => {
      return res.json({ msg: "profile successfully stored" });
    })
    .catch((err) => {
      return res.status(400).json({ err: err });
    });
});



// Check Profile data

router.route("/checkProfile").get(middleware.checkToken, async (req, res) => {
  try {
    const result = await Profile.findOne({ username: req.decoded.username }).exec();

    if (!result) {
      return res.json({ status: false, username: req.decoded.username });
    } else {
      return res.json({ status: true, username: req.decoded.username });
    }
  } catch (err) {
    return res.json({ err: err });
  }
});

router.route("/getData").get(middleware.checkToken, async (req, res) => {
  try {
    const result = await Profile.findOne({ username: req.decoded.username }).exec();

    if (!result) {
      return res.json({ data: [] });
    } else {
      return res.json({ data: result });
    }
  } catch (err) {
    return res.json({ err: err });
  }
});
router.get('/profiles', async (req, res) => {
  try {
    const profiles = await Profile.find();
    res.json(profiles);
  } catch (error) {
    res.status(500).json({ error: 'An error occurred while fetching profiles.' });
  }
});
router.route("/update").patch(middleware.checkToken, async (req, res) => {
  try {
    let profile = await Profile.findOne({ username: req.decoded.username }).exec();
    if (!profile) {
      profile = {};
    }

    const updatedData = {
      name: req.body.name || profile.name,
      profession: req.body.profession || profile.profession,
      DOB: req.body.DOB || profile.DOB,
      titleline: req.body.titleline || profile.titleline,
      about: req.body.about || profile.about,
    };

    const result = await Profile.findOneAndUpdate(
      { username: req.decoded.username },
      { $set: updatedData },
      { new: true }
    ).exec();

    if (!result) {
      return res.json({ data: [] });
    } else {
      return res.json({ data: result });
    }
  } catch (err) {
    return res.json({ err: err.message });
  }
});

// API endpoint to update the profile's salary by username
router.put('/salary/:username', async (req, res) => {
  const { username } = req.params;
  const { salary } = req.body;

  try {
    // Find the profile by username and update the salary
    const updatedProfile = await Profile.findOneAndUpdate({ username }, { salary }, { new: true });

    if (!updatedProfile) {
      return res.status(404).json({ error: 'Profile not found' });
    }

    return res.json(updatedProfile);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Server error' });
  }
});

router.get('/getsalary/:username', async (req, res) => {
  const { username } = req.params;

  try {
    const profile = await Profile.findOne({ username });

    if (!profile) {
      return res.status(404).json({ error: 'Profile not found' });
    }

    return res.json(profile);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Server error' });
  }
});

// router.route("/getDataByName/:name").get(middleware.checkToken, async (req, res) => {
//   try {
//     const result = await Profile.findOne({ name: req.params.name }).exec();

//     if (!result) {
//       return res.json({ data: null, message: 'User not found' });
//     } else {
//       // Assuming you have a field named "profileImage" in your Profile model
//       const fullImageUrl = `http://localhost:5000/${result.profileImage}`;
      
//       return res.json({ data: { img: fullImageUrl } });
//     }
//   } catch (err) {
//     return res.json({ err: err });
//   }
// });

module.exports = router;
