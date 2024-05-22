const Video = require('../model/addClass.model');

async function createVideo(imagePath, ClassName, time,Date,cost,cotchName,allowedNumber,description ) {
  const newVideo = new Video({
    imagePath, ClassName, time,Date,cost,cotchName,allowedNumber,description 
  });

  return newVideo.save();
}

module.exports = {
  createVideo,
};
