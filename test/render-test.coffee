assert = require 'power-assert'
render = require './render'

describe 'render', ->
  context '"text"', ->
    beforeEach ->
      @parsed = ['text']
      @context = {}
      @expected = ['text']

    it 'works', ->
      rendered = render @parsed, @context
      assert.deepEqual rendered, @expected
