const express = require('express');
const CommentService = require('../services/addcomment.service');

const commentService = new CommentService();
const router = express.Router();

router.post('/addComment', async (req, res) => {
  try {
    const comment = await commentService.addComment(req.body);
    res.status(201).json(comment);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error adding comment' });
  }
});


module.exports = router;
