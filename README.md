# Perseus

Perseus is a WIP **in-browser Python-to-JavaScript compiler**.  

The goal is to have standalone cross-browser pretty-printed JavaScript output.  In the far future, additional support for translation to [Node.js][] modules will be implemented as well.

You can look over the code on [github](http://github.com/onurkaraman/Perseus), or the annotated source [here](http://onurkaraman.github.com/Perseus/docs/bool.html).

## Why use it?

- Translate server-side Python code into server-side JavaScript/[Node.js][], for a free performance boost and natural interfacing between server and clients.
- If you just want Python to work in the browser.

##  How it works

The syntactic translation consists of two steps:

- **Parse the Python code into an [Abstract Syntax Tree](http://en.wikipedia.org/wiki/Abstract_syntax_tree) (AST).**

- **Translate each AST node into equivalent Javascript code.**

  By following the Python abstract grammar, we can translate the lowest level nodes, and *recursively* translate their parents, and those parents' parents, etc. in a bottom-up translation scheme.

The semantic translation consists of one step:

- **Load a JavaScript translation of the Python 'built-in' types, functions, etc.**

  We need to do this because these are Python-implementation-dependent.  In CPython (the default implementation of Python), these are written in C (no kidding!), so we *can't* translate these over using Perseus.

## What's left

Work-in-progress is no exaggeration.  While we have the basic functionality down enough for a proof-of-concept, there are lots of things we still need to do:

- **Translate the AST parser into JavaScript**

  We're using the Python standard library [ast](http://docs.python.org/library/ast.html) module right now, but in order for Perseus to completely work in the browser, we need to convert this to JavaScript.
  We should be able to do this using Perseus itself, but as a fallback we could generate a Python parser in JavaScript using [Jison][].

- **Finish AST node translations**

  A brief skim through `src/nodes` will show that there are still a few that haven't been implemented yet, which includes classes, variable/keyword arguments, and import statements.

- **Translate AST node translator into JavaScript**

  As soon as we translate the built-in dependencies, we can translate our translator, using Perseus itself once again.

- **Finish translation of Python's built-ins**

  Only a small subset of the built-in functions have been complete so far, but a quick look through the source code shows that their implementations are mostly trivial.
  Some of Python's built-in types, such as strings, have additional [methods](http://docs.python.org/library/stdtypes.html#string-methods) that need need further translation.

- **Resolve packing/unpacking issue**

  Perseus-translated functions currently take Perseus objects (such as `Int`, `Num`, `Tuple`) as input, and produce them as output.  This is undesirable because the user can't natively use the translated functions without knowing how to convert 
  their arguments into Perseus classes, as in the case of built-in JavaScript primitives.  This should be solvable using `Perseus.pack()` and `Perseus.unpack()` functions and some ingenuity.

- **Miscellaneous**
  - Optimize JavaScript translation of Python built-ins to only include those necessary to run the translated Python code.
  - Ensure compatibility with [JSLint][], and add cross-browser support for JavaScript translation of Python built-ins (e.g. `String.indexOf()` in IE before version 9)
  - Command line tool for some niceties such as concatenating different Python files before translation.

## Credits

- [CoffeeScript][] - CoffeeScript is a little language that compiles into JavaScript.
- [Docco][] - Docco is a quick-and-dirty, hundred-line-long, literate-programming-style documentation generator.
- [Jison][] - Jison generates bottom-up parsers in JavaScript.
- [JSLint][] - The JavaScript Code Quality Tool
- [Markdown][] - Markdown is a text-to-HTML conversion tool for web writers.
- [Node.js][] - Node.js is a server-side JavaScript environment that uses an asynchronous event-driven model.

[CoffeeScript]: http://coffeescript.org
[Docco]: https://github.com/jashkenas/docco
[Jison]: https://github.com/zaach/jison
[JSLint]: http://www.jslint.com/
[Markdown]: http://daringfireball.net/projects/markdown/
[Node.js]: http://nodejs.org/