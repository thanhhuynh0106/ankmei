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


// update current user profile
router.put('/me', verifiedToken, async (req, res) => {
  try {
    const updates = req.body;

    if (!updates || Object.keys(updates).length === 0) {
      return res.status(400).json({ message: 'No updates provided' });
    }

    const allowedFields = ['displayName', 'bio', 'backgroundUrl', 'avatarUrl', 'badgeIds'];
    const filteredUpdates = {};
    
    for (const [key, value] of Object.entries(updates)) {
      if (allowedFields.includes(key)) {
        filteredUpdates[key] = value;
      }
    }

    if (Object.keys(filteredUpdates).length === 0) {
      return res.status(400).json({ 
        message: 'No valid fields to update. Allowed fields: ' + allowedFields.join(', ')
      });
    }

    const user = await User.findByIdAndUpdate(
      req.userId, 
      filteredUpdates, 
      { new: true, runValidators: true }
    ).select('-password');
    
    if (!user) return res.status(404).json({ message: 'User not found' });

    res.json(user);

  } catch (err) {
    console.error('Update user error:', err);
    res.status(500).json({ message: 'Server error' });
  }
});
