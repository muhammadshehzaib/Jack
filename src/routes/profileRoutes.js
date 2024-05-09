const express = require('express');
const router = express.Router();

router.get('/profile', (req, res) => {
    if (!req.session.isLoggedIn) {
        return res.status(401).send('You need to log in');
    }
    res.render('profile'); // Assuming the user is logged in
});
module.exports = router;
