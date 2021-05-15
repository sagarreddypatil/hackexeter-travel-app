require('dotenv').config();

const express = require('express');
const paths = require('./controllers/paths');

const app = express();
app.use(express.json());

app.use('/api/paths', paths);

app.get('/', (req, res) => {
  const body = req.body;
  console.log(body);
  res.send(body);
});

const PORT = process.env.PORT || 3001;

app.listen(PORT, () => {
  console.log(`Server started on port ${PORT}`);
});
