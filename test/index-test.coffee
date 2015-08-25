assert = require 'power-assert'
bHtml = require './'

describe 'index', ->
  context 'example 1', ->
    it 'works', ->
      source = '''
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
      template = bHtml source
      context =
        firstName: 'bouzu'
        lastName: 'ya'
      assert.deepEqual template(context), '''
        <p class="message">first name:<span class="first-name">bouzu</span>
        last name:<span class="last-name">ya</span>.</p>
      '''

  context 'example 2', ->
    it 'works', ->
      source = '''
        <ul
          <li
            @b-repeat user in users
            <span
              @b-text user.name
              @class name
      '''
      template = bHtml source
      context =
        users: [
          name: 'bouzuya'
        ,
          name: 'emanon001'
        ]
      assert.deepEqual template(context), '''
        <ul><li><span class="name">bouzuya</span></li><li><span class="name">emanon001</span></li></ul>
      '''
