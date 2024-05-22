const mongoose = require('mongoose');

const likeSchema = new mongoose.Schema({
  postId: {
    type: String
  },
  publisherName: {
    type: String,
  },
  likerName: {
    type: String,
  },
});

const Like = mongoose.model('Like', likeSchema);

module.exports = Like;
