parse = require './parse'
render = require './render'
renderToString = require './render-to-string'

module.exports = (source, { format } = {}) ->
  format ?= renderToString
  parsed = parse source
  (context) ->
    rendered = render parsed, context
    format rendered, context
