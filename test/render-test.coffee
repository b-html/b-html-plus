assert = require 'power-assert'
render = require './render'

describe 'render', ->
  context 'text', ->
    beforeEach ->
      @parsed = ['text']
      @context = {}
      @expected = ['text']

    it 'works', ->
      rendered = render @parsed, @context
      assert.deepEqual rendered, @expected

  context 'element', ->
    beforeEach ->
      @parsed = [
        name: 'p'
        attributes: [
          name: 'b-text'
          value: 'user.name'
        ]
        children: []
      ]
      @context =
        user:
          name: 'bouzuya'
      @expected = [
        name: 'p'
        attributes: []
        children: ['bouzuya']
      ]

    it 'works', ->
      rendered = render @parsed, @context
      assert.deepEqual rendered, @expected

  context 'elements', ->
    beforeEach ->
      @parsed = [
        'text'
      ,
        name: 'p'
        attributes: [
          name: 'b-text'
          value: 'user.name'
        ]
        children: []
      ]
      @context =
        user:
          name: 'bouzuya'
      @expected = [
        'text'
      ,
        name: 'p'
        attributes: []
        children: ['bouzuya']
      ]

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

  context 'b-repeat', ->
    context 'simple', ->
      beforeEach ->
        @parsed = [
          name: 'p'
          attributes: [
            name: 'b-repeat'
            value: 'item in list'
          ,
            name: 'b-html'
            value: 'item'
          ]
          children: []
        ]
        @context =
          list: [
            'item1'
            'item2'
          ]
        @expected = [
          name: 'p'
          attributes: []
          children: ['item1']
        ,
          name: 'p'
          attributes: []
          children: ['item2']
        ]

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected

    context 'complex', ->
      beforeEach ->
        @parsed = [
          name: 'ul'
          attributes: []
          children: [
            name: 'li'
            attributes: [
              name: 'b-repeat'
              value: 'user in users'
            ]
            children: [
              name: 'span'
              attributes: [
                name: 'b-html'
                value: 'user.name'
              ]
              children: []
            ]
          ]
        ]
        @context =
          users: [
            name: 'bouzuya'
          ,
            name: 'emanon001'
          ]
        @expected = [
          name: 'ul'
          attributes: []
          children: [
            name: 'li'
            attributes: []
            children: [
              name: 'span'
              attributes: []
              children: ['bouzuya']
            ]
          ,
            name: 'li'
            attributes: []
            children: [
              name: 'span'
              attributes: []
              children: ['emanon001']
            ]
          ]
        ]

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected

  context 'b-text', ->
    context 'simple', ->
      beforeEach ->
        @parsed = [
          name: 'p'
          attributes: [
            name: 'b-text'
            value: 'message'
          ]
          children: []
        ]
        @context =
          message: '<b>hello</b>'
        @expected = [
          name: 'p'
          attributes: []
          children: ['&lt;b&gt;hello&lt;/b&gt;']
        ]

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected

    context 'complex', ->
      beforeEach ->
        @parsed = [
          name: 'p'
          attributes: [
            name: 'b-text'
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
          children: ['&lt;b&gt;bouzuya&lt;/b&gt;']
        ]

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected
