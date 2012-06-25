ltx = require 'ltx'
async = require 'async'

createObjectAsync = (input, cb) ->
  output = {}

  attrs = (done) ->
    addAttribute = (key, done) ->
      value = input.attrs[key]
      output["@#{key}"] = value
      done()
    async.forEach Object.keys(input.attrs), addAttribute, done

  children = (done) ->
    addChild = (child, done) ->
      if typeof child is 'string' # Text value for element
        output.text = child
        done()
      else if typeof child is 'object' # Actual child element
        createObjectAsync child, (err, res) ->
          return done err if err?
          output[child.name] ?= []
          output[child.name].push res
          done()
    async.forEach input.children, addChild, done

  async.parallel [attrs, children], (err) -> cb err, output

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

toJSON = (input, cb) ->
  return null unless input?
  input = ltx.parse input
  return null unless input instanceof ltx.Element
  root = {}
  if cb?
    createObjectAsync input, (err, res) ->
      root[input.name] = res
      cb err, root
    return
  else
    root[input.name] = createObject input
    return root

module.exports = toJSON
