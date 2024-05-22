const Video = require('../model/yoga.model');

async function createVideo(exerciseName, description, videoPath) {
  const newVideo = new Video({
    exerciseName,
    description,
    videoPath,
  });

  return newVideo.save();
}

module.exports = {
  createVideo,
};
