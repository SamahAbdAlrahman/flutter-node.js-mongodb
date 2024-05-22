const Video = require('../model/addsubscribtion.model');

async function createVideo(price,month ) {
  const newVideo = new Video({
price,month  });

  return newVideo.save();
}

module.exports = {
  createVideo,
};
