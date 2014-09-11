# setup
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

app.post "/save", passport.authenticate("basic",
  session: false
), (req, res) ->
  console.dir req.body
  res.end "thanks for the data"

# orm
knex = require("knex")(
  client: 'mariasql',
  connection: 
    host     : '127.0.0.1',
    user     : 'root',
    password : 'root',
    database : 'inform',
    charset  : 'utf8'
);

bookshelf = require("bookshelf")(knex);

User = bookshelf.Model.extend({
    tableName: 'users'
});


# start app
server = app.listen(3000, ->
  console.log "monapi is listening on port %d", server.address().port
)
