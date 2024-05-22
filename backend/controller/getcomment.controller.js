const express = require('express');
const CommentService = require('../services/getcomment.service');

const commentService = new CommentService();
const router = express.Router();


router.get('/getCommentsByBlog/:blogId', async (req, res) => {
    const blogId = req.params.blogId;
  
    if (!blogId) {
      return res.status(400).json({ message: 'Missing blogId parameter' });
    }
  
    try {
      // Retrieve comments by blogId
      const comments = await commentService.getCommentsByBlogId(blogId);
      res.status(200).json(comments);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Error fetching comments' });
    }
  });
  

module.exports = router;
