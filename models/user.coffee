module.exports = (sequelize, DataTypes) ->
  User = sequelize.define("user",
    {
    Nummer:
      type: DataTypes.INTEGER
      primaryKey: true
    },
    {
      tableName: "personaltable"
      timestamps: false
      freezeTableName: true
    }
  )
  User
