# config
express = require("express")
bodyParser = require("body-parser")
app = express()
passport = require("passport")
BasicStrategy = require("passport-http").BasicStrategy
app.use passport.initialize()
app.use bodyParser.json()

# user auth
passport.use new BasicStrategy((username, password, done) ->
  console.log "authenticate"
  return done(null, "user_basti")  if username is "basti" and password is "basti"
  done null, false,
    message: "du nicht"
)

# routes
app.get "/", (req, res) ->
  res.send "home"

app.get "/login", (req, res) ->
  res.send "please login"

app.post "/save", passport.authenticate("basic",
  session: false
), (req, res) ->
  console.dir req.body
  res.end "thanks for the data"


# start app
server = app.listen(3000, ->
  console.log "Listening on port %d", server.address().port
)
