# glg-nectar
This element provides access to GLG's nectar search service, listening for the specified
event and retrieving data from the configured indexes. Use it to wrap a particular element
that you'd like to trigger data retrieval.

    _ = require('lodash')
    Polymer 'glg-nectar',

## Attributes and Change Handlers
### urls
The urls to the server, can be either a single or array of urls if client-side load balancing is needed.

### entities
The nectar entities/indexes to load data from.  Can either be an array or a string.

## Events
### entitiesChanged
Fired when a query is being sent to nectar. Great place to update the UI
with progress/spinners.

      entitiesChanged: ->
        e = @entities
        e = JSON.parse(e) if e[0] is '['
        @entitiesParsed = e

##Methods
####loadResults
This retrieves results from nectar and fires the 'results' event when results are available.

      loadResults: (evt) ->
        if evt.detail.value?.length > 0
          query =
            entity: @entitiesParsed,
            query: evt.detail.value
            options: JSON.parse(@options) ? {}

          @fire 'nectarQuery', query
          @$.socket.send query, (response) =>
            @results = response.results
            @resultset = _.map response.results, (results,type) -> { type, results }
            @fire 'results', { query: query, results: @results, resultset: @resultset }
        else
          query=
            entity: null,
            query: "",
            options: JSON.parse(@options) ? {}

          @results = null
          @resultset = []
          @fire 'results', { query: query, results: @results, resultset: @resultset }
          Platform.performMicrotaskCheckpoint()
