file = require './file'
_ = require 'lodash'
el = require('testx').element

expectText = (matcher) ->
  (args) ->
    expecteds = _.omit(args, ['file', 'url', 'link', 'timeout'])
    if args.file
      file.getText(args.file)
      .then(matcher expecteds)
    else if args.url
      url = if args.url.match(/^https?:\/\//i) then args.url else browser?.baseUrl + args.url
      file.download(url)
      .then(file.getText)
      .then(matcher expecteds)
    else if args.link
      link = el(args.link)
      link.wait(parseInt(args.timeout || 5000))
      link.getAttribute('href')
      .then(file.download)
      .then(file.getText)
      .then(matcher expecteds)
    else
      throw new Error 'One of "file", "url" or "link" parameters has to be set in order to use this keyword.'

toMatch = (match = true) -> (expecteds) ->
  (text) ->
    for key, expected of expecteds
      if match
        expect(text).toMatch expected
      else
        expect(text).not.toMatch expected

module.exports =
  'check text in file': expectText(toMatch true)
  'check text not in file': expectText(toMatch false)
