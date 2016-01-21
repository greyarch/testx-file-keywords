path = require 'path'
fs = require 'fs'
http = require 'http'
q = require 'q'
temp = require("temp").track()
download = require('./util').download

module.exports =
  download: download

  getText: (file) ->
    deferred = q.defer()
    fs.readFile file, "utf8", (err, data) ->
      deferred.reject err if err
      deferred.resolve data
    deferred.promise
