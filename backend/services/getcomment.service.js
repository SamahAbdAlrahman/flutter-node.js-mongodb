const Comment = require('../model/comment.model');

class getcomment {
  

  async getCommentsByBlogId(blogId) {
    try {
      const comments = await Comment.find({ blogId });
      return comments;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = getcomment;
