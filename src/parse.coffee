bHtml = require 'b-html'

format = (node, options) ->
  switch node.type
    when 'comment'
      type: node.type
      value: node.value
      name: null
      attributes: []
      children: []
    when 'doctype'
      type: node.type
      value: node.value
      name: null
      attributes: []
      children: []
    when 'element'
      type: node.type
      name: node.name
      attributes: node.attributes.map (attr) ->
        name: attr.name
        value: attr.value
      children: node.children.map((i) -> format i, options)
    when 'empty element'
      type: node.type
      name: node.name
      attributes: node.attributes.map (attr) ->
        name: attr.name
        value: attr.value
      children: node.children.map((i) -> format i, options)
    when 'root element'
      node.children.map((i) -> format i, options)
    when 'text'
      node.content
    when 'default text'
      node.content
    when 'new line text'
      '\n' + node.content

module.exports = (source) ->
  bHtml source, { format }
