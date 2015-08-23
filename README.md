# b-html-plus

A template language based on [b-html](https://github.com/b-html/b-html).

## Usage

```javascript
import bHtml from 'b-html-plus';

let source = `<ul
  <li
    @b-repeat user in users
    @b-text user.name
`;
let template = bHtml.compile(source);

let context = {
  users: [
    { name: 'bouzuya' },
    { name: 'emanon001' }
  ]
};
let html = template(context);

html === '<ul><li>bouzuya</li><li>emanon001</li></ul>';
```

## Syntax

- `b-html` ... `innerHTML`
- `b-repeat <item> in <list>` ... repeat
- `b-text` ... `innerText`

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][email]&gt; ([http://bouzuya.net][url])

[user]: https://github.com/bouzuya
[email]: mailto:m@bouzuya.net
[url]: http://bouzuya.net
