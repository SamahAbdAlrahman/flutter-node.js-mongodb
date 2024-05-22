const VideoService = require('../services/addClass.service');

async function addclass(req, res, next) {
  try {
    const { imagePath, ClassName, time,Date,cost,cotchName,allowedNumber,description } = req.body;
    const classData = await VideoService.createVideo(imagePath, ClassName, time,Date,cost,cotchName,allowedNumber,description);
    res.json({ status: true, success: classData });

    console.log(req.file);
  console.log(req.body);
  } catch (error) {
    console.error(error);
    next(error);
  }
  
}

module.exports = {
  addclass,
};
