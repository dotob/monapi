db = require("../models")
exports.index = (req, res) ->
  res.render "index",
    title: "monapi"
