const express = require('express');
const mongoose = require('mongoose');
const Place = require('../models/place');

const router = express.Router();

router.get('/', (req, res) => {
  Place.find({}).then((places) => {
    res.json(places);
  });
});

router.get('/nearby', (req, res, next) => {
  const latitude = Number(req.query.latitude);
  const longitude = Number(req.query.longitude);
  const distance = req.query.distance;

  Place.find({
    location: {
      $near: {
        $geometry: {
          coordinates: [longitude, latitude],
        },
        $maxDistance: distance,
      },
    },
  })
    .then((places) => {
      res.send(places);
    })
    .catch((err) => next(err));
});

router.get('/:id', (req, res, next) => {
  Place.findById(req.params.id)
    .then((place) => {
      if (place) {
        res.json(place);
      } else {
        res.status(404).end();
      }
    })
    .catch((err) => next(err));
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
