# glg-nectar
A polymer component that provides a declarative way to drop GLG's nectar
autocomplete service onto a page.  It exposes the various search options
available as published attributes.

See the [nectar API](https://github.com/glg/nectar/tree/prod#api "Nectar API") for more information about the service
itself and the [status page](https://nectar.glgroup.com/status "Nectar Status") to see what entities/indexes are available.

To see the events, attributes, and methods of the glg-nectar polymer
component, take a look at the [literate coffeescript source files](src/glg-nectar.litcoffee).

## usage
Include the glg-nectar polymer component in your package.json.

    "glg-nectar":"git://github.com/custom-elements/glg-nectar#master"

Import the glg-nectar.html in your HTML.

    <link rel="import" href="node_modules/glg-nectar/src/glg-nectar.html"></script>

## polyfills
Using the glg-nectar polymer component of course presumes that the
browsers in use will support:
* custom elements
* HTML imports
* templates
* shadow dom

If older browsers need to be supported, you should include the
webcomponents polyfill in your HTML.

`<script src="node_modules/webcomponents.js/webcomponents.js"></script>`
