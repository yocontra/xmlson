ltx = require 'ltx'

createObject = (input) ->
  output = {}
  output["@#{key}"] = value for key, value of input.attrs # Attributes
  for child in input.children # Children
    if typeof child is 'string' # Text value for element
      output.text = child
    else if typeof child is 'object' # Actual child element
      output[child.name] ?= []
      output[child.name].push createObject child
  return output

toJSON = (input) ->
  return null unless input?
  input = ltx.parse input
  return null unless input instanceof ltx.Element
  root = {}
  root[input.name] = createObject input
  return root

module.exports = toJSON
