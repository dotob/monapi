express = require("express")
routes = require("./routes")
hours = require("./routes/hours")
http = require("http")
bodyParser = require("body-parser")
path = require("path")
db = require("./models")
passport = require("passport")
BasicStrategy = require("passport-http").BasicStrategy
app = express()

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", __dirname + "/views"
app.set "view engine", "jade"
app.use express.favicon()
app.use express.logger("dev")
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use passport.initialize()
app.use app.router
app.use bodyParser.json()

# user auth
passport.use new BasicStrategy (username, password, done) ->
  console.log "search for user: #{username} with password: #{password}"
  db.user.find(
    where:
      Nummer: username
  )
  .success((u) ->
    if u?
      console.log "found user: #{u.Nummer}"
      done null, {id:123}
    else
      done null, false
  )

# development only
app.use express.errorHandler() if "development" is app.get("env")

# routes
app.get "/", routes.index
app.post "/hours/month/:year/:month", passport.authenticate("basic",{ session: false}), hours.postMonth

db.sequelize.authenticate().complete (err) ->
  if err
    throw err
  else
    http.createServer(app).listen app.get("port"), ->
      console.log "monapi listening on port " + app.get("port")
