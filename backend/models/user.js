const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    displayName: {
        type: String,
        default: "Guest",
    },
    username: {
        type: String,
        required: true,
        unique: true,
    },
    backgroundUrl: {
        type: String,
        default: null,
    },
    avatarUrl: {
        type: String,
        default: null,
    },
    badgeIds: {
        type: [String],
        default: [],
    },
    bio: {
        type: String,
        default: '',
    },

    // backend fields
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    createdAt: {
        type: Date,
        default: Date.now,
    },
    provider: {
        type: String,
        enum: ['local', 'github'],
        default: 'local',
    },
    userRole: {
        type: String,
        enum: ['user', 'admin'],
        default: 'user',
    }
});

module.exports = mongoose.model('User', userSchema);