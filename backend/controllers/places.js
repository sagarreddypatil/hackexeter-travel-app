const express = require('express');
const mongoose = require('mongoose');
const Place = require('../models/place');

const router = express.Router();

router.get('/', (req, res) => {
  Place.find({}).then((places) => {
    res.json(places);
  });
});

router.post('/', (req, res, next) => {
  const body = req.body;

  const newPlace = new Place({
    creator: mongoose.Types.ObjectId(body.user),
    location: {
      type: 'Point',
      coordinates: [body.longitude, body.latitude],
    },
    name: body.name,
    address: body.address,
    zipCode: body.zipCode,
  });

  newPlace
    .save()
    .then((result) => res.json(result))
    .catch((err) => next(err));
});

module.exports = router;
