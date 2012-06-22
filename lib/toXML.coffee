ltx = require 'ltx'
    
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


toXML = (input) ->
  return null unless input?
  return null unless typeof input is 'object'
  return null if Array.isArray input
  rootName = Object.keys(input)[0]
  output = new ltx.Element rootName
  input = input[rootName]
  return createStanza(input, output).toString()

module.exports = toXML
