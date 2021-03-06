const mongoose = require('mongoose');
const { pointSchema } = require('./utils');

const placeSchema = new mongoose.Schema({
  creator: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
  },
  location: {
    type: pointSchema,
    index: '2dsphere',
    required: true,
  },
  name: String,
  address: String,
  zipCode: String,
  reviews: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Review',
    },
  ],
});

placeSchema.set('toJSON', {
  transform: (document, returnedObject) => {
    returnedObject.id = returnedObject._id.toString();
    delete returnedObject.location._id;
    delete returnedObject.location.type;
    delete returnedObject._id;
    delete returnedObject.__v;
  },
});

module.exports = mongoose.model('Place', placeSchema);
