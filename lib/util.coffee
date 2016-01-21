path = require 'path'
fs = require 'fs'
q = require 'q'
_ = require 'lodash'
temp = require("temp").track()
request = require 'request'

module.exports =
  download: (url, options = {}) ->
    deferred = q.defer()
    opts =
      prefix: 'testx-'
    _.extend opts, options
    dest = temp.path opts
    file = fs.createWriteStream(dest)
    file.on 'finish', ->
      file.close()
      deferred.resolve dest
    request(url).pipe(file).on 'error', (err) -> deferred.reject err
    deferred.promise
