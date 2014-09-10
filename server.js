// config
var express = require('express');
var bodyParser = require('body-parser');
var app = express();
var passport = require('passport');
var BasicStrategy = require('passport-http').BasicStrategy

app.use(passport.initialize());
app.use(bodyParser.json())

// user auth
passport.use(new BasicStrategy(
  function(username, password, done) {
    console.log("authenticate");
    if(username=="basti" && password=="basti"){
      return done(null, "user_basti");
    }
    return done(null, false, {message: "du nicht"});
  })
);

// routes
app.get('/', function(req, res){
    res.send('home');
});
app.get('/login', function(req, res){
    res.send('please login');
});
app.post('/save', passport.authenticate('basic', { session: false}), 
  function(req, res){
      console.dir(req.body);
      res.end('thanks for the data');
  }
);


// start app
var server = app.listen(3000, function() {
  console.log('Listening on port %d', server.address().port);
});
