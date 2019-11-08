# Welcome to the webpack-based javascript folder!

This project uses the [webpacker gem](https://github.com/rails/webpacker) to manage static javascript assets with [webpack](https://webpack.js.org/) instead of the legacy [sprockets](https://stackoverflow.com/questions/31828795/what-sprockets-mean-in-rails) solution. Webpack is the default in rails 6.

## Linting

This project uses [eslint](https://eslint.org/) to lint (style checking and some error checking) all javascript code.
The style rules for this project can be found [here](../../.eslintrc), and the reference for what these rules do can be found [here](https://eslint.org/docs/rules/)
The linter can be called with `docker-compose run rails bin/lint.sh --js`.
If you would like it to preform automatic fixes where possible, you can call `docker-compose run rails bin/lint.sh --js --fix`.
Note that all linter fixes for javascript are safe, so the `--fix-safe` flag does the same thing as `--fix` when `bin/lint.sh` is run with the `--js` flag.

## Including webpack assets in html.erb file
The files in the [`pack`](./packs) directory are special, as they are considered entry points for webpack.
They can be referenced from an `html.erb` (i.e. [`application.html.erb`](../views/layouts/application.html.erb)) file with `<%= javascript_pack_tag 'filename_without_extension' =>`.
Therefore, any javascript not `include`'d in a pack file loaded with the current page will not be executed.

## Managing javascript packages
Webpack uses [`yarn`](https://yarnpkg.com/lang/en/) to manage packages, which in turn gets them from [npm](https://www.npmjs.com/).
The [`package.json`](../../package.json) file contains the user readable configuration for npm and `yarn`, while [`yarn.lock`](../../yarn.lock) holds the exact copy of every package involved.

_Note: all yarn commands *must* be executed from the rails container, unless you know what you are doing._

### Adding a package

    yarn add [package]

Adding a dev dependency

    yarn add [package] --dev

### Updating the lock file

    yarn upgrade

or

    yarn upgrade-interactive

### Getting rid of a package

    yarn remove [package]

Or delete the relevant line from the [`package.json`](../../package.json)

### Docker notes
Executing commands from the `rails` container can be done with the shell created by `docker-compose run rails bash`.
Also note that any changes made to the npm (javascript/webpack/yarn) packages will require a rebuild of the `rails` container afterwords, (i.e. `docker-compose build rails`).

#### Yarn is complaining about packages!
First, try rebuilding the rails container.
This will solve most problems.
If that fails, try deleting the `yarn.lock` file.

#### I deleted yarn.lock and now docker won't build!
Comment out the line that `COPY`s `yarn.lock` in the `Dockerfile`, rebuild the container, run `docker-compose up`, and then uncomment the line.

## Modern javascript
The use of webpack allows for [modern javascript syntax](https://flaviocopes.com/javascript-modern-syntax/) and [include style library](https://javascript.info/import-export) management, both of which allow for much better constraints on what javascript is capable of, and make it easier to figure out where your functions are coming from.

#### `let` and `const` vs `var`
`var`, the old way of declaring variables in javascript, is *function* scoped, not block scoped.
That means that this:

    for (var ii = 0; ii < 10; ii++) {
        // Do some stuff
    }
    console.log(ii);

will print 10, not throw a syntax error.
`let`, on the other hand, is block scoped, so the previous code would throw an error.
`const` is block scoped like `let`, and does not allow variables to be reassigned.
For example:

    const a = 1;
    a = [1,2,3];

will throw an error.
Note that this does not mean that the contents of the object cannot be changed.
This code:

    const a = {"foo": 1};
    a.foo = 2;
    a["foo"] = 3;
    a.bar = 4;
    a["bar"] = 5;
    console.log(a);

is perfectly valid, and will print `{foo: 3, bar: 5}`.
The same holds for arrays.
Effectively, the pointer that the variable `a` is holding in both cases cannot change, but `const` makes no guarantees about what you do with that pointer.

#### Arrow functions
Arrow functions are reductively a replacement for the old anonymous function syntax, `function(arg1){ /* do some stuff */ }`, with `(arg1) => { /* do some stuff */ }`.
Note that if there is just one statement in the function body, the curly braces can be omitted, like so: `(num) => num + 2`.

The only relevant difference between the two is what `this` refers to at call time, and in general arrow functions do what you expect, while old-style `function ()` definitions do not.

#### Destructuring

    const foo = {"a": 1, "b": 2};
    const {a, b} = foo;

Does what it looks like it does.
Note that this is also valid:

    const foo = {"a": 1, "b": 2};
    const {a} = foo;

which makes `a === 1` true.
Further, array destructuring also works:

    const foo = ["a", "b", "c"];
    const [myletter, myOtherLetter] = foo;
    console.log(myOtherLetter); // prints "b"

#### Imports and exports
[This](https://javascript.info/import-export) good job of conceptually explaining `import` and `export`.
