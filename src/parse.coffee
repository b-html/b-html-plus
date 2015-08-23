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
module.exports = (source) ->
  element = {}
  elements = [element]
  elements
