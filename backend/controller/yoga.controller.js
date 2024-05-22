const VideoService = require('../services/yoga.service');

async function addVideo(req, res, next) {
  try {
    const { exerciseName, description, videoPath } = req.body;
    const videoData = await VideoService.createVideo(exerciseName, description, videoPath);
    res.json({ status: true, success: videoData });

    console.log(req.file);
  console.log(req.body);
  } catch (error) {
    console.error(error);
    next(error);
  }
  
}

module.exports = {
  addVideo,
};
