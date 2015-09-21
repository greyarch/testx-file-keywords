q = require 'q'
Download = require 'download'
temp = require("temp").track()
path = require 'path'
fs = require 'fs'

module.exports =
  download: (url) ->
    deferred = q.defer()
    filePath = temp.path
      prefix: 'testx-'
    options =
      mode: '755'
      dest: path.dirname(filePath)
    new Download(options)
    .get(url)
    .run (err, files) ->
      deferred.reject(err) if err
      deferred.resolve files[0]
    deferred.promise

  getText: (file) ->
    deferred = q.defer()
    fs.readFile file, "utf8", (err, data) ->
      deferred.reject err if err
      deferred.resolve data
    deferred.promise
