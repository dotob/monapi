fs = require("fs")
path = require("path")
Sequelize = require("sequelize")
_ = require("lodash")

sequelize = new Sequelize("inform", "root", "root",
  dialect: "mariadb"
  port: 3306
)
db = {}
fs.readdirSync(__dirname)
  .filter((file) ->
    (file.indexOf(".") isnt 0) and (file isnt "index.coffee") and (file.slice(-7) is ".coffee")
  )
  .forEach (file) ->
    model = sequelize.import(path.join(__dirname, file))
    console.log "add model #{model.name} from file #{file}"
    db[model.name] = model

Object.keys(db).forEach (modelName) ->
  if db[modelName].options.hasOwnProperty("associate")
    db[modelName].options.associate db

module.exports = _.extend(
  sequelize: sequelize
  Sequelize: Sequelize
, db)
