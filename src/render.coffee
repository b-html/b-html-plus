# Array<Element> -> Array<Element> | Element | string

escapeHtml = (html) ->
  html
  .replace /&/g, '&amp;'
  .replace /</g, '&lt;'
  .replace />/g, '&gt;'
  .replace /"/g, '&quot;'

get = (key, context) ->
  key.split(/\./).reduce(((c, key) -> c[key]), context)

getAttr = (element, attr) ->
  element.attributes.filter((i) -> i.name is attr)[0]

hasAttr = (element, attr) ->
  element.attributes.some((i) -> i.name is attr)

renderElement = (element, context) ->
  switch element.type
    when 'comment'
      { type, value } = element
      return [{ type, value }]
    when 'doctype'
      { type, value } = element
      return [{ type, value }]
    when 'text'
      { type, value } = element
      return [{ type, value }]
    when 'new line text'
      { type, value } = element
      return [{ type, value }]
    else
      null # do nothing
  if hasAttr element, 'b-repeat'
    return renderElements element, context
  if hasAttr element, 'b-if'
    attr = element.attributes.filter((i) -> i.name is 'b-if')[0]
    value = get attr.value, context
    return [] unless value
  { type, name, children, attributes } = element
  attrs = []
  events = []
  attributes.forEach (attr) ->
    switch attr.name
      when 'b-attr'
        attr.value.split(/\s*,\s*/).forEach (a) ->
          [n, v] = a.split /\s*:\s*/
          attrs.push
            name: n
            value: get v, context
      when 'b-html'
        html = get attr.value, context
        children = [
          type: 'text'
          value: html
        ]
      when 'b-if'
        # do nothing
        null
      when 'b-on'
        attr.value.split(/\s*,\s*/).forEach (a) ->
          [n, v] = a.split /\s*:\s*/
          events.push
            name: n
            value: get v, context
      when 'b-text'
        html = get attr.value, context
        text = escapeHtml html
        children = [
          type: 'text'
          value: text
        ]
      else
        attrs.push { name: attr.name, value: attr.value }
  children = children.reduce (c, child) ->
    c.concat renderElement child, context
  , []
  [{ type, name, attributes: attrs, children, events }]

renderElements = (element, context) ->
  { type, name, children, attributes } = element
  attrs = attributes.filter (i) ->
    i.name isnt 'b-repeat'
  attr = getAttr element, 'b-repeat'
  match = attr.value.match /^\s*(\w+)\s*in\s*(\w+)\s*$/
  throw new Error('b-repeat:' + attr.value) unless match?
  [_, itemName, listName] = match
  context[listName].reduce (c, item) ->
    context[itemName] = item
    c.concat renderElement { type, name, attributes: attrs, children }, context
  , []

module.exports = (elements, context) ->
  elements.reduce (c, e) ->
    c.concat renderElement e, context
  , []
