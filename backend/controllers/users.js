const express = require('express');
// const mongoose = require('mongoose');
const User = require('../models/user');

const router = express.Router();

router.get('/', (req, res) => {
  User.find({}).then((places) => {
    res.json(places);
  });
});

router.post('/', (req, res, next) => {
  const body = req.body;

  console.log(body);

  const newUser = new User({
    name: body.name,
    dateOfBirth: body.dateOfBirth,
    points: 0,
    lastLocation: {
      type: 'Point',
      coordinates: [body.longitude, body.latitude],
    },
  });

  newUser
    .save()
    .then((result) => res.json(result))
    .catch((err) => next(err));
});

module.exports = router;
