# Array<Element> -> Array<Element> | Element | string
renderElement = (element, context) ->
  return [element] if typeof element is 'string'
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
  [{ name, attributes, children }]

module.exports = (elements, context) ->
  renderElement elements[0], context
