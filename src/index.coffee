bHtml = require 'b-html'
render = require './render'
renderToString = require './render-to-string'

module.exports = (source, { format } = {}) ->
  format ?= renderToString
  parsed = bHtml source, format: (nodes) -> nodes
  (context) ->
    rendered = render parsed, context
    format rendered, context
