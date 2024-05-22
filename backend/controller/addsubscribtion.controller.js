const VideoService = require('../services/addsubscribtion.service');

async function addSub(req, res, next) {
  try {
    const {price,month } = req.body;
    const classData = await VideoService.createVideo(price,month);
    res.json({ status: true, success: classData });

    console.log(req.file);
  console.log(req.body);
  } catch (error) {
    console.error(error);
    next(error);
  }
  
}

module.exports = {
  addSub,
};
