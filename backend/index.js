require('dotenv').config();

const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');
const users = require('./controllers/users');
const paths = require('./controllers/paths');
const places = require('./controllers/places');
const reviews = require('./controllers/reviews');

mongoose
  .connect(process.env.MONGO_CONNECTION_STRING, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false,
    useCreateIndex: true,
  })
  .then(() => {
    console.log('Connected to MongoDB');
  })
  .catch((err) => {
    console.log('Failed to connect to MongoDB!');
    console.log(err);
  });

const app = express();
app.use(cors());
app.use(express.json());

app.use('/api/paths', paths);
app.use('/api/places', places);
app.use('/api/users', users);
app.use('/api/reviews', reviews);

app.get('/', (req, res) => {
  const body = req.body;
  console.log(body);
  res.send(body);
});

const errorHandler = (err, req, res, next) => {
  console.log(err.message);

  if (err.name === 'ValidationError') {
    return res.status(400).send({ error: err.message, details: err.errors });
  }

  next(err);
};

app.use(errorHandler);

const PORT = process.env.PORT || 3001;

app.listen(PORT, () => {
  console.log(`Server started on port ${PORT}`);
});
