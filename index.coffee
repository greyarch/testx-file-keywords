_ = require 'lodash'
el = require('testx').element
file = require './lib/file'
pdf = require './lib/pdf'

getText = (retriever, args) ->
  if args.file
    retriever.getText(args.file)
  else if args.url
    url = if args.url.match(/^https?:\/\//i) then args.url else browser?.baseUrl + args.url
    retriever.download(url)
    .then(retriever.getText)
  else if args.link
    link = el(args.link)
    link.wait(parseInt(args.timeout || 5000))
    link.getAttribute('href')
    .then(retriever.download)
    .then(retriever.getText)
  else
    throw new Error 'One of "file", "url" or "link" parameters has to be set in order to use this keyword.'

expectToMatch = (retriever, match = true) ->
  (args) ->
    expecteds = _.omit args, ['file', 'url', 'link', 'timeout']
    getText(retriever, args).then (text) ->
      for key, expected of expecteds
        if match
          expect(text).toMatch expected
        else
          expect(text).not.toMatch expected

module.exports =
  'check text in file': expectToMatch file
  'check text not in file': expectToMatch file, false
  'check in pdf': cipdf = expectToMatch pdf
  'check not in pdf': cnipdf = expectToMatch pdf, false
  'check text in pdf': cipdf
  'check text not in pdf': cnipdf
