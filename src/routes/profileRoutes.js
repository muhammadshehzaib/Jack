const express = require('express');
const router = express.Router();

router.get('/profile', (req, res) => {
    res.render('profile'); // Make sure 'homepage.ejs' exists in your views folder
});

module.exports = router;
