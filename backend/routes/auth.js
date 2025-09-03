const express = require('express');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const router = express.Router();
const User = require('../models/user');

router.post('/register', async (req, res) => {
    const { username, email, password } = req.body;
    if (!username || !email || !password) {
        return res.status(400).json({ message: 'All fields are required!?' });
    }

    const checkExistingUser = await User.findOne({ $or: [{ email }, { username }] });

    if (checkExistingUser) {
        return res.status(400).json({ message: 'Email or username already in use!?' });
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    const newUser = new User({
        username,
        email,
        password: hashedPassword,
    });

    try {
        const savedUser = await newUser.save();
        const token = jwt.sign({_id: savedUser._id}, process.env.TOKEN_SECRET, { expiresIn: 60 * 60 * 24 })
        res.status(201).json({ 
            message: 'User registered successfully!?', 
            userId: savedUser._id,
            token,
            user: {
                _id: savedUser._id,
                username: savedUser.username,
                email: savedUser.email,
                displayName: savedUser.displayName ?? savedUser.username,
                backgroundUrl: savedUser.backgroundUrl,
                avatarUrl: savedUser.avatarUrl,
                provider: savedUser.provider,
                userRole: savedUser.userRole,
                badgeIds: savedUser.badgeIds,
                createdAt: savedUser.createdAt,
            }
        });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
});


router.post('/login', async (req, res) => {
    const { username, password } = req.body;
    if (!username || !password) {
        return res.status(400).json({ message: 'All fields are required!?' });
    }

    const user = await User.findOne({ username });
    if (!user) {
        return res.status(400).json({ message: 'Invalid credentials!?' });
    }

    const checkPassword = await bcrypt.compare(password, user.password);
    if (!checkPassword) {
        return res.status(400).json({ message: 'Invalid credentials!?' });
    }

    const token = jwt.sign({_id: user._id}, process.env.TOKEN_SECRET, { expiresIn: 60 * 60 * 24 })
    res.json({ 
        message: 'Logged in successfully',
        token,
        userId: user._id,
        user: {
            _id: user._id,
            username: user.username,
            email: user.email,
            displayName: user.displayName ?? user.username,
            backgroundUrl: user.backgroundUrl,
            avatarUrl: user.avatarUrl,
            provider: user.provider,
            userRole: user.userRole,
            badgeIds: user.badgeIds,
            createdAt: user.createdAt,
        }
    });
})



module.exports = router;