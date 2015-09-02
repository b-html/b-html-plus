# Array<Element> -> String
formatAttr = ({ name, value }, options) ->
  if value?
    "#{name}=\"#{value}\""
  else
    "#{name}"

format = (node, options) ->
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
      name = node.name
      attributes = node.attributes.map((i) -> formatAttr i, options).join ' '
      attributes = if attributes.length > 0
        ' ' + attributes
      else
        ''
      "<#{name}#{attributes} />"
    when 'text'
      value = node.value
      value
    when 'new line text'
      value = node.value
      '\n' + value
    else
      throw new Error('unknown type: ' + node.type)

module.exports = (elements, options) ->
  elements.map((i) => format i, options).join ''
