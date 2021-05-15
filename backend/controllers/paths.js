const express = require('express');

const router = express.Router();

router.get('/', (req, res) => {
  res.send('paths endpoint');
});

module.exports = router;
