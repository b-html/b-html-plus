# b-html-plus

A template language based on [b-html][b-html/b-html].

It is also an example for [b-html][b-html/b-html]'s format option.

## Usage

```javascript
import assert from 'assert';
import bHtml from 'b-html-plus';

let source = `<ul
  <li
    @b-repeat user in users
    @b-text user.name
`;
let template = bHtml(source);
let context = {
  users: [
    { name: 'bouzuya' },
    { name: 'emanon001' }
  ]
};
let html = template(context);
assert(html === '<ul><li>bouzuya</li><li>emanon001</li></ul>');
```

## Syntax

- `b-attr <attrs>` ... attributes (e.g. `@b-attr width: w, height: h`)
- `b-html <html>` ... `innerHTML` (e.g. `@b-html html`)
- `b-if <condition>` ... remove tree if condition is falsy (e.g. `@b-if show`)
- `b-repeat <item> in <list>` ... repeat (e.g. `@b-repeat user in users`)
- `b-text <text>` ... `innerText` (e.g. `@b-html text`)

## Badges

[![Circle CI](https://circleci.com/gh/b-html/b-html-plus.svg?style=svg)](https://circleci.com/gh/b-html/b-html-plus)

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][email]&gt; ([http://bouzuya.net][url])

[user]: https://github.com/bouzuya
[email]: mailto:m@bouzuya.net
[url]: http://bouzuya.net

[b-html/b-html]: https://github.com/b-html/b-html
