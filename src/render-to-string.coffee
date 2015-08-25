# Array<Element> -> String
formatAttr = (node, options) ->
  name = node.name
  value = node.value
  if value?
    "#{name}=\"#{value}\""
  else
    "#{name}"

format = (node, options) ->
  return node if typeof node is 'string'
  switch node.type
    when 'comment'
      value = node.value
      "<!--#{value}-->"
    when 'doctype'
      value = node.value
      "<!DOCTYPE #{value}>"
    when 'element'
      name = node.name
      attributes = node.attributes.map((i) -> formatAttr i, options).join ' '
      attributes = if attributes.length > 0
        ' ' + attributes
      else
        ''
      children = node.children.map((i) -> format i, options).join ''
      """
      <#{name}#{attributes}>#{children}</#{name}>
      """
    when 'empty element'
      attributes = node.attributes.map((i) -> formatAttr i, options).join ' '
      attributes = if attributes.length > 0
        ' ' + attributes
      else
        ''
      "<#{node.name}#{attributes} />"

module.exports = (elements, options) ->
  elements.map((i) => format i, options).join ''
