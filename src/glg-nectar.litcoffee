# glg-nectar
This element provides access to GLG's nectar autocomplete service. Use the `options` published attribute
to configure nectar's query options and the `loadResults` method to fire a query to the service.  This
element then fires a `results` event when results are ready.

    Polymer 'glg-nectar',

## Attributes
### urls
The url(s) to the server, can be either a single url or an array of urls that the
websocket component will use to find the fastest responding end point. See the glg-nectar.html file
for usage.

### entities
The nectar entities/indexes from which to load data.  Can either be an array of entity names or
a string that is the name of a single entity.

### options
A javascript object containing one or more of the available nectar search configuration options.
https://github.com/glg/nectar#api

## Event Handlers
### entitiesChanged
Parse entities published attribute whenever it changes.

      entitiesChanged: ->
        @entitiesParsed = JSON.parse(@entities) ? @entities

### optionsChanged
Parse options published attribute whenever it changes.

      optionsChanged: ->
        @optionsParsed = JSON.parse(@options) ? {}

## Methods
### query
Retrieves results from nectar based on query text and fires the 'results' event
when results are available.

      query: (val) ->
        input = if val.length > 0 then val else ''
        msg =
          entity: @entitiesParsed
          query: input
          options: @optionsParsed

        @fire 'nectarQuery', msg
        @$.socket.send msg, (response) =>
          @results = if val.length > 0 then response.results else {}
          @fire 'results', { msg: msg, results: @results }

### jump
Retrieves results from nectar based on object ID and fires the 'results' event
when results are available.

      jump: (val) ->
        input = if val.length > 0 then val else ''
        msg =
          entity: @entitiesParsed
          jump: input
          options: @optionsParsed

        @fire 'nectarQuery', msg
        @$.socket.send msg, (response) =>
          @results = if val.length > 0 then response.results else {}
          @fire 'results', { msg: msg, results: @results }
