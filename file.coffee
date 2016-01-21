path = require 'path'
fs = require 'fs'
http = require 'http'
q = require 'q'
temp = require("temp").track()

module.exports =
  download: (url) ->
    deferred = q.defer()
    dest = temp.path
      prefix: 'testx-'
    file = fs.createWriteStream(dest)
    http.get url, (response) ->
      response.pipe file
      file.on 'finish', ->
        file.close()
        deferred.resolve dest
    .on 'error', (err) -> deferred.reject err
    deferred.promise

  getText: (file) ->
    deferred = q.defer()
    fs.readFile file, "utf8", (err, data) ->
      deferred.reject err if err
      deferred.resolve data
    deferred.promise
