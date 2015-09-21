q = require 'q'
download = require 'download-file'
temp = require('temp').track()
path = require 'path'
fs = require 'fs'

module.exports =
  download: (url) ->
    deferred = q.defer()
    filePath = temp.path
      prefix: 'testx-'
    options =
      directory: path.dirname(filePath)
      filename: path.basename(filePath)
    download url, options, (err) ->
      deferred.reject(err) if err
      deferred.resolve filePath
    deferred.promise

  getText: (file) ->
    deferred = q.defer()
    fs.readFile file, "utf8", (err, data) ->
      deferred.reject err if err
      deferred.resolve data
    deferred.promise
