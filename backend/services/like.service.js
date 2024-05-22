const Like = require('../model/like.model');

class LikeService {
  async addLike(postId, publisherName, likerName) {
    const newLike = new Like({
      postId,
      publisherName,
      likerName,
    });

    return newLike.save();
  }
}

module.exports = new LikeService();
