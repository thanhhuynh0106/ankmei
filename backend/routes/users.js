var express = require('express');
const verifiedToken = require('../middlewares/verifyToken');
var router = express.Router();

const User = require('../models/user');

router.get('/', verifiedToken, (req, res) => {
    User.find({})
      .then(users => res.json(users))
      .catch(err => res.status(500).json({ error: err.message }));
})


module.exports = router;

// get current user profile
router.get('/me', verifiedToken, async (req, res) => {
  try {
    const user = await User.findById(req.userId).select('-password');
    if (!user) return res.status(404).json({ message: 'User not found' });
    res.json(user);
  } catch (err) {
    res.status(500).json({ message: 'Server error' });
  }
});
