const mongoose = require('mongoose');

const commentSchema = new mongoose.Schema({
  name: String,
  image: String,
  commentText: String,
  blogId: String,
});

const Comment = mongoose.model('Comment', commentSchema);

module.exports = Comment;
