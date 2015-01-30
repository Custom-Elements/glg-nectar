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
Parse entities published attribute whenever it changes.

      entitiesChanged: ->
        @entitiesParsed = JSON.parse(@entities) ? @entities

### optionsChanged
Parse options published attribute whenever it changes.

      optionsChanged: ->
        @optionsParsed = JSON.parse(@options) ? {}

##Methods
####loadResults
This retrieves results from nectar and fires the 'results' event when results are available.

      loadResults: (evt) ->
        # TODO: Add support for jump to by ID
        if evt.detail.value?.length > 0
          query =
            entity: @entitiesParsed
            query: evt.detail.value
            options: @optionsParsed

          @fire 'nectarQuery', query
          @$.socket.send query, (response) =>
            @results = response.results
            @fire 'results', { query: query, results: @results }
        else
          query=
            entity: @entitiesParsed
            query: ""
            options: @optionsParsed

          @results = {}
          @fire 'results', { query: query, results: @results }
