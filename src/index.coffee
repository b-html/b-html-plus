parse = require './parse'
render = require './render'
renderToString = require './render-to-string'

module.exports = (source) ->
  parsed = parse source
  (context) ->
    rendered = render parsed, context
    renderToString rendered
