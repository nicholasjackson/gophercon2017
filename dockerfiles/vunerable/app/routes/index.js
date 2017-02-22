var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { name: req.query.name });
});

router.post('/', function(req, res, next) {
  console.log(req.body)
  res.status(403).end(); 
});
module.exports = router;
