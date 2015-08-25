bHtml = require 'b-html'

###
NOTE:

String -> Array<Element>

Element: {
  name: string,
  attributes: Array<{
    name: string,
    value: string
  }>,
  children: Array<Element>
}
###

format = (node, options) ->
  switch node.type
    when 'element'
      name: node.name
      attributes: node.attributes.map (attr) ->
        name: attr.name
        value: attr.value
      children: node.children.map((i) -> format i, options).filter (i) -> i?
    when 'empty element'
      name: node.name
      attributes: node.attributes.map (attr) ->
        name: attr.name
        value: attr.value
      children: node.children.map((i) -> format i, options).filter (i) -> i?
    when 'root element'
      node.children.map((i) -> format i, options).filter (i) -> i?
    when 'text'
      node.content
    when 'default text'
      node.content
    when 'new line text'
      '\n' + node.content
    else
      # TODO: support comment and doctype
      null

module.exports = (source) ->
  bHtml source, { format }
