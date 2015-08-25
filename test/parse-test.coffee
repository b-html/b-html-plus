assert = require 'power-assert'
parse = require './parse'

describe 'parse', ->
  it 'works', ->
    elements = parse '''
      <p
        @class message
        first name:
        <span
          @b-text firstName
          @class first-name
        |last name:
        <span
          @b-text lastName
          @class last-name
        >.
    '''
    assert.deepEqual elements, [
      name: 'p'
      attributes: [
        name: 'class'
        value: 'message'
      ]
      children: [
        'first name:'
      ,
        name: 'span'
        attributes: [
          name: 'b-text'
          value: 'firstName'
        ,
          name: 'class'
          value: 'first-name'
        ]
        children: []
      ,
        '\nlast name:'
      ,
        name: 'span'
        attributes: [
          name: 'b-text'
          value: 'lastName'
        ,
          name: 'class'
          value: 'last-name'
        ]
        children: []
      ,
        '.'
      ]
    ]
