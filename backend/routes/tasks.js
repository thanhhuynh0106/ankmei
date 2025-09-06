const express = require('express');
const verifyToken = require('../middlewares/verifyToken');
const Task = require('../models/task');

const router = express.Router();


router.post('/', verifyToken, (req, res) => {
    try {
        const { title, description, category, priority, status, assignees, dueDate, subtasks } = req.body;
        if (!title) {
            return res.status(400).json({ message: 'Title is required' });
        }
        const newTask = new Task({
            title,
            description,
            category,
            priority,
            status,
            createdBy: req.userId,
            assignees,
            dueDate,
            subtasks
        });
        newTask.save()
            .then(task => res.status(201).json(task))
            .catch(err => res.status(500).json({ error: err.message }));
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
})


module.exports = router;