const express = require('express');
const mongoose = require('mongoose');
const Path = require('../models/path');

const router = express.Router();

router.get('/', (req, res) => {
  Path.find({}).then((paths) => {
    res.json(paths);
  });
});

router.post('/', (req, res, next) => {
  const body = req.body;

  const newPath = new Path({
    creator: mongoose.Types.ObjectId(body.user),
    reviews: body.reviews,
    places: body.places,
    hints: body.hints
  });

  newPath
    .save()
    .then((result) => res.json(result))
    .catch((err) => next(err));
});

module.exports = router;
