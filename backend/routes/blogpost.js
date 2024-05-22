const express = require("express");
const router = express.Router();
const BlogPost = require("../model/blogpost.model");
const middleware = require("../middleware");
const multer = require("multer");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./uploads");
  },
  filename: (req, file, cb) => {
    cb(null, req.params.id + ".jpg");
  },
});

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 6,
  },
});

router.route("/add/coverImage/:id").patch(middleware.checkToken, upload.single("img"), async (req, res) => {
  try {
    const result = await BlogPost.findOneAndUpdate(
      { _id: req.params.id },
      {
        $set: {
          coverImage: req.file.path,
        },
      },
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

router.route("/Add").post(middleware.checkToken, (req, res) => {
  const blogpost = BlogPost({
    username: req.decoded.username,
    title: req.body.title,
    body: req.body.body,
  });
  blogpost
    .save()
    .then((result) => {
      res.json({ data: result["_id"] });
    })
    .catch((err) => {
      console.log(err), res.json({ err: err });
    });
});

router.route("/getOwnBlog").get(middleware.checkToken, async (req, res) => {
  try {
    const result = await BlogPost.find({ username: req.decoded.username }).exec();

    return res.json({ data: result });
  } catch (err) {
    return res.json({ err: err.message });
  }
});
router.route("/gethisBlog/:username").get(async (req, res) => {
  try {
    const result = await BlogPost.find({ username: req.params.username }).exec();

    return res.json({ data: result });
  } catch (err) {
    return res.json({ err: err.message });
  }
});


router.route("/getOtherBlog").get(middleware.checkToken, async (req, res) => {
  try {
    const result = await BlogPost.find({ username: { $ne: req.decoded.username } }).exec();

    return res.json({ data: result });
  } catch (err) {
    return res.json({ err: err.message });
  }
});


router.route("/delete/:id").delete(middleware.checkToken, async (req, res) => {
  try {
    const result = await BlogPost.findOneAndDelete({
      $and: [{ username: req.decoded.username }, { _id: req.params.id }],
    }).exec();

    if (result) {
      console.log(result);
      return res.json("Blog deleted");
    } else {
      return res.json("Blog not deleted");
    }
  } catch (err) {
    return res.json({ err: err.message });
  }
});

module.exports = router;
