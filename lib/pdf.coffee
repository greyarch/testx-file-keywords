path = require 'path'
fs = require 'fs'
http = require 'http'
q = require 'q'
pdfText = require 'pdf-text'
temp = require("temp").track()
download = require('./util').download

module.exports =
  download: (url) -> download url,
      suffix: '.pdf'

  getText: (file) ->
    deferred = q.defer()
    pdfText file, (err, chunks) ->
      deferred.reject err if err
      deferred.resolve (c.trim() for c in chunks).join(' ')
    deferred.promise
