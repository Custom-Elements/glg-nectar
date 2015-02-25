# glg-nectar
This element provides access to GLG's nectar autocomplete service. Use the `options` published attribute
to configure nectar's query options and either the `query` or `jump` methods to fire a query to the service.
When results are ready the element then fires a `results` event.

    Polymer 'glg-nectar',

## Attributes
### urls
The url(s) to the server, can be either a single url or a JSON representation of an array of urls that the
websocket component will use to find the fastest responding end point. See the glg-nectar.html file
for usage.

### entities
The nectar entities/indexes from which to load data.  Can either be a JSON representation of array of entity names in JSON notation or
a string that is the name of a single entity.

### options
A JSON representation of an object containing one or more of the available nectar search configuration options.
https://github.com/glg/nectar#api

## Change-event Handlers
None

## Methods
### search
Retrieves results for either query or jump

      search: (val, type='query') ->
        msg =
            entity: @entities?.split ','
            options:
              interleave: @interleave.toLowerCase() is 'true'
              boostPrefix: @boostPrefix.toLowerCase() is 'true'
              scoreThreshold: @scoreThreshold
              howMany: @howMany
              startPos: @startPos
              secondarySortField: @secondarySortField
              secondarySortOrder: @secondarySortOrder
        if val?.length > 0 and @entities?.length > 0
          msg[type] = val
          @fire 'nectarQuery', msg
          @$.socket.send msg, (response) =>
            @fire 'results', { msg: msg, results: response.results }
        else
          @fire 'results', { msg: msg, results: [] }

### query
Retrieves results from nectar based on query text and fires the 'results' event
when results are available.

      query: (val) ->
        @search val, 'query'

### jump
Retrieves results from nectar based on object ID and fires the 'results' event
when results are available.

      jump: (val) ->
        @search val, 'jump'
