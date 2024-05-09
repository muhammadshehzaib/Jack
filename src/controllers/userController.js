const Member = require('../models/Member');
const bcrypt = require('bcryptjs');

exports.signup = (req, res) => {
    res.render('signup');
};

exports.doSignup = async (req, res) => {
  try {
      const { name, email, password } = req.body;
      const memberId = await Member.create(name, email, password);
      req.session.memberId = memberId;  // Auto-login after signup
      req.session.isLoggedIn = true;
      res.json({ message: 'Signup and login successful', memberId: memberId });
  } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Error during registration', error: error.message });
  }
};


exports.login = (req, res) => {
    res.render('login');
};

exports.doLogin = async (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
      return res.status(400).json({ message: 'Email and password must be provided.' });
  }
  const member = await Member.findByEmail(email.trim());
  if (member && await bcrypt.compare(password, member.PasswordHash)) {
      req.session.memberId = member.MemberID;  // Store member ID in session
      req.session.isLoggedIn = true;  // Flag as logged-in
      console.log("Session Data:", req.session);  // Debugging output
      res.json({ message: 'Login successful', memberId: member.MemberID });
  } else {
      res.status(401).json({ message: 'Invalid credentials' });
  }
};


exports.getMember = async (req, res) => {
  try {
    const member = await Member.findById(req.params.id);
    if (!member) {
      return res.status(404).json({ message: 'Member not found' });
    }
    res.json(member);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error fetching member' });
  }
};

exports.updateMember = async (req, res) => {
  try {
    const { email, name, password } = req.body;
    let hashedPassword;

    // Check if the password is already hashed
    if (password.startsWith('$2a$') || password.startsWith('$2b$') || password.startsWith('$2y$')) {
      hashedPassword = password;  // Use the hashed password directly if it's already hashed
    } else {
      hashedPassword = await bcrypt.hash(password, 8);  // Hash the password if it's not
    }

    const result = await Member.updateById(req.params.id, email, name, hashedPassword);
    if (result.affectedRows) {
      res.json({ message: 'Member updated successfully' });
    } else {
      res.status(500).json({ message: 'Error updating member' });
    }
  } catch (error) {
    console.error("Failed to update member:", error);
    res.status(500).json({ message: 'Error updating member', error: error.message });
  }
};

