const express = require('express');
const router = express.Router();
const commentController = require('../controllers/userController')
const sessionController = require('../controllers/userController');

router.get('/browse-cards', (req, res) => {
    res.render('browseCards'); // Make sure 'browseCards.ejs' exists in your views folder
});

router.get('/card/:id', (req, res) => {
    res.render('card',{id:req.params.id});
})

router.get('/expansions', (req, res) => {
    res.render('expansions'); // Make sure 'expansions.ejs' exists in your views folder
});

router.get('/dashboard', (req, res) => {
    res.render('dashboard'); // Make sure 'dashboard.ejs' exists in your views folder
});
router.post('/comments/:cardId', commentController.postComment);
router.get('/api/session-status', sessionController.getSessionStatus);
router.get('/comments/:cardId', commentController.getCommentsByCardId);


module.exports = router;
