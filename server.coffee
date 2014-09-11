# setup
express = require("express")
bodyParser = require("body-parser")
app = express()
passport = require("passport")
BasicStrategy = require("passport-http").BasicStrategy
app.use passport.initialize()
app.use bodyParser.json()

# user auth
passport.use new BasicStrategy (username, password, done) ->
  console.log "authenticate"
  new User({ Nummer:username }).fetch().then (u) -> 
    if u
      done null, u
    else
      done null, false

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
  client: 'mariasql'
  connection: 
    host     : 'localhost'
    user     : 'root'
    password : 'root'
    db       : 'inform'
)

bookshelf = require("bookshelf")(knex);

User = bookshelf.Model.extend(
  tableName: 'personaltable'
)

# start app
server = app.listen(3000, ->
  console.log "monapi is listening on port %d", server.address().port
)
