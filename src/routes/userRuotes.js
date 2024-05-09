const express = require("express");
const router = express.Router();
const userController = require("../controllers/userController");

router.get('/signup', userController.signup);
router.post('/signup', userController.doSignup);
router.get('/login', userController.login);
router.post('/login', userController.doLogin);
router.get('/members/:id', userController.getMember);
router.put('/members/:id', userController.updateMember);

module.exports = router;
