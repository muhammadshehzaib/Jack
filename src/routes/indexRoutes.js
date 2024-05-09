const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    res.render('homepage'); // Make sure 'homepage.ejs' exists in your views folder
});

module.exports = router;
