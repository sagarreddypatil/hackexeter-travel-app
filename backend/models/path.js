const mongoose = require('mongoose');
const { pointSchema } = require('./utils');
//copy of place.js
const pathSchema = new mongoose.Schema({
  creator: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
  },
  name: String,
  reviews: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
    },
  ],
  places: [{
    type: pointSchema,
    required: true,
  }],
  hints: [String]
});

pathSchema.set('toJSON', {
  transform: (document, returnedObject) => {
    returnedObject.id = returnedObject._id.toString();
    delete returnedObject._id;
    delete returnedObject.__v;
  },
});

module.exports = mongoose.model('Path', pathSchema);
