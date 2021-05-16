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
