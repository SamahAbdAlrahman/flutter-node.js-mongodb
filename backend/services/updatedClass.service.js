const Class = require('../model/addClass.model');

async function updateClass(classId, updatedData) {
  try {
    const updatedClass = await Class.findByIdAndUpdate(classId, updatedData, { new: true });
    return updatedClass;
  } catch (error) {
    throw new Error('Failed to update class');
  }
}

module.exports = {
  updateClass,
};
