const classService = require('../services/updatedClass.service');

async function updateClass(req, res) {
  const classId = req.params.classId;
  const updatedData = req.body;

  try {
    const updatedClass = await classService.updateClass(classId, updatedData);
    res.json(updatedClass);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}

module.exports = {
  updateClass,
};
