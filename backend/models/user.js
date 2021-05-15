const mongoose = require('mongoose');
const { pointSchema } = require('./utils');

const userSchema = new mongoose.Schema({
  name: String,
  dateOfBirth: Date,
  points: Number,
  visitedPlaces: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Place',
    },
  ],
  completedPaths: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Path',
    },
  ],
  lastLocation: {
    type: pointSchema,
    required: true,
  },
});

module.exports = mongoose.model('User', userSchema);
