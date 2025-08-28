const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    displayName: {
        type: String,
        required: true,
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

    // backend fields
    email: {
        type: String,
        required: true,
        unique: true,
    },
    hashedPassword: {
        type: String,
        required: true,
    },
    createdAt: {
        type: Date,
        default: Date.now,
    },
    provider: {
        type: String,
        enum: ['local', 'google', 'facebook'],
        default: 'local',
    },
});

module.exports = mongoose.model('User', userSchema);