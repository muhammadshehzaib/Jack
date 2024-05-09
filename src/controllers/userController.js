const Member = require('../models/Member');
const bcrypt = require('bcryptjs');

exports.signup = (req, res) => {
    res.render('signup');
};

exports.doSignup = async (req, res) => {
    try {
        const { name, email, password } = req.body;
        const memberId = await Member.create(name, email, password);
        res.json({ message: 'Signup successful', memberId: memberId });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Error during registration', error: error.message });
    }
};

exports.login = (req, res) => {
    res.render('login');
};

exports.doLogin = async (req, res) => {
    try {
        // Check if both email and password are provided
        const { email, password } = req.body;
        if (!email || !password) {
            return res.status(400).json({ message: 'Email and password must be provided.' });
        }

        const member = await Member.findByEmail(email.trim()); // Using trim() to remove any extraneous whitespace
        if (!member) {
            await new Promise(resolve => setTimeout(resolve, 1000));
            return res.status(401).json({ message: 'Invalid credentials' });
        }
        
        const isMatch = await bcrypt.compare(password, member.PasswordHash);
        if (!isMatch) {
            await new Promise(resolve => setTimeout(resolve, 1000));
            return res.status(401).json({ message: 'Invalid credentials' });
        }

        res.json({ message: 'Login successful', memberId: member.MemberID });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Error during login', error: error.message });
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


// const Member = require('../models/Member');
// const bcrypt = require('bcryptjs');

// exports.signup = (req, res) => {
//     res.render('signup');
// };

// exports.doSignup = async (req, res) => {
//     try {
//         const { name, email, password } = req.body;
//         const memberId = await Member.create(name, email, password);
//         req.session.user = { memberId: memberId, name: name };
//         res.json({ message: 'Signup successful', memberId: memberId });
//     } catch (error) {
//         console.error(error);
//         res.status(500).json({ message: 'Error during registration', error: error.message });
//     }
// };

// exports.login = (req, res) => {
//     res.render('login');
// };

// exports.doLogin = async (req, res) => {
//     try {
//         // Check if both email and password are provided
//         const { email, password } = req.body;
//         if (!email || !password) {
//             return res.status(400).json({ message: 'Email and password must be provided.' });
//         }

//         const member = await Member.findByEmail(email.trim()); // Using trim() to remove any extraneous whitespace
//         if (!member) {
//             await new Promise(resolve => setTimeout(resolve, 1000));
//             return res.status(401).json({ message: 'Invalid credentials' });
//         }
        
//         const isMatch = await bcrypt.compare(password, member.PasswordHash);
//         if (!isMatch) {
//             await new Promise(resolve => setTimeout(resolve, 1000));
//             return res.status(401).json({ message: 'Invalid credentials' });
//         }
//         req.session.user = { memberId: member.MemberID, name: member.Name };
//         res.json({ message: 'Login successful', memberId: member.MemberID });
//     } catch (error) {
//         console.error(error);
//         res.status(500).json({ message: 'Error during login', error: error.message });
//     }
// };
// exports.getMember = async (req, res) => {
//   try {
//     const member = await Member.findById(req.params.id);
//     if (!member) {
//       return res.status(404).json({ message: 'Member not found' });
//     }
//     res.json(member);
//   } catch (error) {
//     console.error(error);
//     res.status(500).json({ message: 'Error fetching member' });
//   }
// };

// exports.updateMember = async (req, res) => {
//   try {
//     const { email, name, password } = req.body;
//     let hashedPassword;

//     // Check if the password is already hashed
//     if (password.startsWith('$2a$') || password.startsWith('$2b$') || password.startsWith('$2y$')) {
//       hashedPassword = password;  // Use the hashed password directly if it's already hashed
//     } else {
//       hashedPassword = await bcrypt.hash(password, 8);  // Hash the password if it's not
//     }

//     const result = await Member.updateById(req.params.id, email, name, hashedPassword);
//     if (result.affectedRows) {
//       res.json({ message: 'Member updated successfully' });
//     } else {
//       res.status(500).json({ message: 'Error updating member' });
//     }
//   } catch (error) {
//     console.error("Failed to update member:", error);
//     res.status(500).json({ message: 'Error updating member', error: error.message });
//   }
// };

