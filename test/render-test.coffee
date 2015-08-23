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

  context 'b-html', ->
    context 'context.message', ->
      beforeEach ->
        @parsed = [
          name: 'p'
          attributes: [
            name: 'b-html'
            value: 'message'
          ]
          children: []
        ]
        @context =
          message: '<b>hello</b>'
        @expected = [
          name: 'p'
          attributes: []
          children: ['<b>hello</b>']
        ]

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected

    context 'context.user.name', ->
      beforeEach ->
        @parsed = [
          name: 'p'
          attributes: [
            name: 'b-html'
            value: 'user.name'
          ]
          children: []
        ]
        @context =
          user:
            name: '<b>bouzuya</b>'
        @expected = [
          name: 'p'
          attributes: []
          children: ['<b>bouzuya</b>']
        ]

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected

    context 'children', ->
      beforeEach ->
        @parsed = [
          name: 'p'
          attributes: []
          children: [
            name: 'span'
            attributes: [
              name: 'b-html'
              value: 'user.name'
            ]
            children: []
          ]
        ]
        @context =
          user:
            name: '<b>bouzuya</b>'
        @expected = [
          name: 'p'
          attributes: []
          children: [
            name: 'span'
            attributes: []
            children: ['<b>bouzuya</b>']
          ]
        ]

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected
