# Array<Element> -> Array<Element> | Element | string

renderElements = (element, context) ->
  name = element.name
  children = element.children.slice()
  attributes = element.attributes.filter (i) ->
    i.name isnt 'b-repeat'
  attr = element.attributes.filter((i) -> i.name is 'b-repeat')[0]
  match = attr.value.match /^\s*(\w+)\s*in\s*(\w+)\s*$/
  throw new Error('b-repeat:' + attr.value) unless match?
  itemName = match[1]
  list = context[match[2]]
  list.reduce (c, item) ->
    context[itemName] = item
    c.concat renderElement({ name, attributes, children }, context)
  , []

renderElement = (element, context) ->
  return [element] if typeof element is 'string'
  if element.attributes.some((i) -> i.name is 'b-repeat')
    return renderElements element, context
  name = element.name
  children = element.children.slice()
  attributes = []
  element.attributes.forEach (attr) ->
    switch attr.name
      when 'b-html'
        html = attr.value.split(/\./).reduce(((c, key) -> c[key]), context)
        children = [html]
      else
        attributes.push attr
  children = children.reduce (c, child) ->
    c.concat renderElement child, context
  , []
  [{ name, attributes, children }]

module.exports = (elements, context) ->
  renderElement elements[0], context
