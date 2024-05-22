const express = require('express');
const commentController = require('../controller/addcomment.controller');
const getcomment = require('../controller/getcomment.controller');

const router = express.Router();

router.use('/comments', commentController);
router.use('/comments', getcomment);

module.exports = router;
