const express = require('express');
const mongoose = require('mongoose');
const Path = require('../models/path');
const Place = require('../models/place');

const router = express.Router();

router.get('/', (req, res) => {
  Path.find({}).then((paths) => {
    res.json(paths);
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
      Path.find({})
        .then((paths) => {
          let result = [];
          for (let path of paths) {
            for (let place of places) {
              if (path.places[0].toString() === place.id.toString()) {
                result.push(path);
              }
            }
          }
          res.json(result);
        })
        .catch((err) => next(err));
    })
    .catch((err) => next(err));
});

router.post('/', (req, res, next) => {
  const body = req.body;

  const newPath = new Path({
    creator: mongoose.Types.ObjectId(body.user),
    name: body.name,
    places: body.places.map(mongoose.Types.ObjectId),
    hints: body.hints,
  });

  newPath
    .save()
    .then((result) => res.json(result))
    .catch((err) => next(err));
});

module.exports = router;
