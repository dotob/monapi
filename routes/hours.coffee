db = require("../models")
exports.postMonth = (req, res) ->
  console.log "year: #{req.params.year}"
  console.log "month: #{req.params.month}"
  console.dir req.body
  # check for deckblatt finished state
  # remove all data from selected month
  # add all new data
  res.end "thanks for the data"
