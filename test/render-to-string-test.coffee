assert = require 'power-assert'
renderToString = require './render-to-string'

describe 'renderToString', ->
  beforeEach ->
    @rendered = [
      type: 'element'
      name: 'ul'
      attributes: []
      children: [
        type: 'element'
        name: 'li'
        attributes: []
        children: [
          type: 'element'
          name: 'span'
          attributes: []
          children: [
            type: 'text'
            value: 'bouzuya'
          ]
        ]
      ,
        type: 'element'
        name: 'li'
        attributes: []
        children: [
          type: 'element'
          name: 'span'
          attributes: []
          children: [
            type: 'text'
            value: 'emanon001'
          ]
        ]
      ]
    ]
    @expected = '<ul><li><span>bouzuya</span></li><li><span>emanon001</span></li></ul>'

  it 'works', ->
    assert renderToString(@rendered) is @expected
