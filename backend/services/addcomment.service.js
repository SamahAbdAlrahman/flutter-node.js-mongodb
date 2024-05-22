const Comment = require('../model/comment.model');

class addComment {
  async addComment(commentData) {
    try {
      const comment = new Comment(commentData);
      const savedComment = await comment.save();
      return savedComment;
    } catch (error) {
      throw error;
    }
  }


}

module.exports = addComment;
