const LikeService = require('../services/like.service');

class LikeController {
  async addLike(req, res) {
    try {
      const { postId, publisherName, likerName } = req.body;

      const like = await LikeService.addLike(postId, publisherName, likerName);

      res.json(like);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  }
}

module.exports = new LikeController();
