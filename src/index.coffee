bHtml = require 'b-html'
render = require './render'
renderToString = require './render-to-string'

module.exports = (source, { format } = {}) ->
  format ?= renderToString
  # parsed is b-html object
  parsed = bHtml source, format: (nodes) -> nodes
  (context) ->
    # rendered is b-html-plus object
    rendered = render parsed, context
    # format b-html-plus object to any object
    format rendered, context
