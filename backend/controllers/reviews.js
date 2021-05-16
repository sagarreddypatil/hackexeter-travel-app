const express = require('express');
const mongoose = require('mongoose');
const Review = require('../models/review');

const router = express.Router();

router.get('/', (req, res) => {
  Review.find({}).then((reviews) => {
    res.json(reviews);
  });
});

router.get('/for/:id', (req, res, next) => {
  Review.find({ for: req.params.id })
    .then((result) => {
      res.json(result);
    })
    .catch((err) => next(err));
});

router.get('/:id', (req, res, next) => {
  Review.findById(req.params.id)
    .then((review) => {
      res.json(review);
    })
    .catch((err) => next(err));
});

router.post('/', (req, res, next) => {
  const body = req.body;
  const newReview = new Review({
    author: mongoose.Types.ObjectId(body.author),
    stars: body.stars,
    text: body.text,
    forModel: body.forModel,
    for: body.for,
  });

  newReview
    .save()
    .then((result) => res.json(result))
    .catch((err) => next(err));
});

module.exports = router;
