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

userSchema.set('toJSON', {
  transform: (document, returnedObject) => {
    returnedObject.id = returnedObject._id.toString();
    delete returnedObject.lastLocation._id;
    delete returnedObject.lastLocation.type;
    delete returnedObject._id;
    delete returnedObject.__v;
  },
});

module.exports = mongoose.model('User', userSchema);
