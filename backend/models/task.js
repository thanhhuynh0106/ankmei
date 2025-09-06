const mongoose = require('mongoose');

const SubtaskSchema = new mongoose.Schema({
    title: { type: String, required: true },
    isCompleted: { type: Boolean, default: false },
    assignees: [{ type: mongoose.Schema.Types.ObjectId, ref: "User" }],
    orderIndex: { type: Number, default: 0 },
    dueDate: { type: Date, default: null },
}, {_id: true, timestamps: true})


const TaskSchema = new mongoose.Schema({
  title: { type: String, required: true },
  description: { type: String, default: "" },
  category: { type: String, default: "general" },

  priority: { 
    type: String, 
    enum: ["low", "medium", "high", "urgent"], 
    default: "low" 
  },
  status: { 
    type: String, 
    enum: ["todo", "inProgress", "completed", "cancelled"], 
    default: "todo" 
  },
  createdBy: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  assignees: [{ type: mongoose.Schema.Types.ObjectId, ref: "User" }],
  dueDate: { type: Date, default: null },
  progress: { type: Number, default: 0 },

  subtasks: {type: [SubtaskSchema], default: []},

}, { timestamps: true });

module.exports = mongoose.model("Task", TaskSchema);


