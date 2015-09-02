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
        type: 'element'
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
        type: 'element'
        name: 'p'
        attributes: []
        children: ['bouzuya']
        events: []
      ]

    it 'works', ->
      rendered = render @parsed, @context
      assert.deepEqual rendered, @expected

  context 'elements', ->
    beforeEach ->
      @parsed = [
        'text'
      ,
        type: 'element'
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
        type: 'element'
        name: 'p'
        attributes: []
        children: ['bouzuya']
        events: []
      ]

    it 'works', ->
      rendered = render @parsed, @context
      assert.deepEqual rendered, @expected

  context '@b-attr', ->
    context 'simple', ->
      beforeEach ->
        @parsed = [
          type: 'element'
          name: 'canvas'
          attributes: [
            name: 'b-attr'
            value: 'width: w, height: h'
          ]
          children: []
        ]
        @context =
          w: 765
          h: 876
        @expected = [
          type: 'element'
          name: 'canvas'
          attributes: [
            name: 'width'
            value: '765'
          ,
            name: 'height'
            value: '876'
          ]
          children: []
          events: []
        ]

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected

    context 'complex', ->
      beforeEach ->
        @parsed = [
          type: 'element'
          name: 'canvas'
          attributes: [
            name: 'b-attr'
            value: 'width: image.width, height: image.height'
          ]
          children: []
        ]
        @context =
          image:
            width: 12
            height: 24
        @expected = [
          type: 'element'
          name: 'canvas'
          attributes: [
            name: 'width'
            value: '12'
          ,
            name: 'height'
            value: '24'
          ]
          children: []
          events: []
        ]

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected

  context '@b-html', ->
    context 'simple', ->
      beforeEach ->
        @parsed = [
          type: 'element'
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
          type: 'element'
          name: 'p'
          attributes: []
          children: ['<b>hello</b>']
          events: []
        ]

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected

    context 'complex', ->
      beforeEach ->
        @parsed = [
          type: 'element'
          name: 'p'
          attributes: []
          children: [
            type: 'element'
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
          type: 'element'
          name: 'p'
          attributes: []
          children: [
            type: 'element'
            name: 'span'
            attributes: []
            children: ['<b>bouzuya</b>']
            events: []
          ]
          events: []
        ]

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected

  context '@b-if', ->
    context 'simple', ->
      beforeEach ->
        @parsed = [
          type: 'element'
          name: 'p'
          attributes: [
            name: 'b-if'
            value: 'isShow'
          ]
          children: []
        ]
        @context =
          isShow: false
        @expected = []

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected

    context 'complex', ->
      beforeEach ->
        @parsed = [
          type: 'element'
          name: 'ul'
          attributes: []
          children: [
            type: 'element'
            name: 'li'
            attributes: [
              name: 'b-if'
              value: 'item.visible'
            ,
              name: 'b-repeat'
              value: 'item in list'
            ,
              name: 'b-text'
              value: 'item.name'
            ]
            children: []
          ]
        ]
        @context =
          list: [
            name: 'show1'
            visible: true
          ,
            name: 'hide1'
            visible: false
          ,
            name: 'show2'
            visible: true
          ,
            name: 'hide2'
            visible: false
          ]
        @expected = [
          type: 'element'
          name: 'ul'
          attributes: []
          children: [
            type: 'element'
            name: 'li'
            attributes: []
            children: ['show1']
            events: []
          ,
            type: 'element'
            name: 'li'
            attributes: []
            children: ['show2']
            events: []
          ]
          events: []
        ]

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected

  context '@b-repeat', ->
    context 'simple', ->
      beforeEach ->
        @parsed = [
          type: 'element'
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
          type: 'element'
          name: 'p'
          attributes: []
          children: ['item1']
          events: []
        ,
          type: 'element'
          name: 'p'
          attributes: []
          children: ['item2']
          events: []
        ]

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected

    context 'complex', ->
      beforeEach ->
        @parsed = [
          type: 'element'
          name: 'ul'
          attributes: []
          children: [
            type: 'element'
            name: 'li'
            attributes: [
              name: 'b-repeat'
              value: 'user in users'
            ]
            children: [
              type: 'element'
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
              children: ['bouzuya']
              events: []
            ]
            events: []
          ,
            type: 'element'
            name: 'li'
            attributes: []
            children: [
              type: 'element'
              name: 'span'
              attributes: []
              children: ['emanon001']
              events: []
            ]
            events: []
          ]
          events: []
        ]

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected

  context '@b-text', ->
    context 'simple', ->
      beforeEach ->
        @parsed = [
          type: 'element'
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
          type: 'element'
          name: 'p'
          attributes: []
          children: ['&lt;b&gt;hello&lt;/b&gt;']
          events: []
        ]

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected

    context 'complex', ->
      beforeEach ->
        @parsed = [
          type: 'element'
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
          type: 'element'
          name: 'p'
          attributes: []
          children: ['&lt;b&gt;bouzuya&lt;/b&gt;']
          events: []
        ]

      it 'works', ->
        rendered = render @parsed, @context
        assert.deepEqual rendered, @expected
