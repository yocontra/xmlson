ltx = require 'ltx'
async = require 'async'

createStanzaAsync = (input, output, cb) ->
  create = (key, done) ->
    value = input[key]
    if typeof value is 'string'
      if key is 'text' # Text value
        output.t value
        return done()
      else if key.indexOf('@') is 0 and key.length > 1 # Attribute
        output.attrs ?= {}
        [_,name] = key.split '@'
        output.attrs[name] = value
        return done()
      else # Child with text, no attributes
        output.c(key).t value
        return done()
    else if Array.isArray value # Multiple children
      addChild = (el, done) -> createStanzaAsync el, output.c(key), done
      async.forEach value, addChild, done
    return
  async.forEach Object.keys(input), create, (err) -> cb err, output
  return

createStanza = (input, output) ->
  for key, value of input
    if typeof value is 'string'
      if key is 'text' # Text value
        output.t value
      else if key.indexOf('@') is 0 and key.length > 1 # Attribute
        output.attrs ?= {}
        [_,name] = key.split '@'
        output.attrs[name] = value
      else # Child with text, no attributes
        output.c(key).t value
    else if Array.isArray value # Multiple children
      createStanza el, output.c(key) for el in value
  return output

toXML = (input, cb) ->
  return null unless input?
  return null unless typeof input is 'object'
  return null if Array.isArray input
  rootName = Object.keys(input)[0]
  output = new ltx.Element rootName
  input = input[rootName]
  if cb?
    createStanzaAsync input, output, (err, res) ->
      res = res.toString() if res?
      cb err, res
    return
  else
    return createStanza(input, output).toString()

module.exports = toXML
