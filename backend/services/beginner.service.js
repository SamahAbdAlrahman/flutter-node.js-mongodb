const Video = require('../model/beginner.model');

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
