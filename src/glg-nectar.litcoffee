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
### entitiesChanged
Parse entities published attribute whenever it changes. Entities must be an array of strings.

      entitiesChanged: ->
        try
          @entitiesParsed = JSON.parse(@entities)
        catch err
          console.warn "Could not JSON.parse entities attribute: #{err}"
          @entitiesParsed = []

### optionsChanged
Parse options published attribute whenever it changes.

      optionsChanged: ->
        try
          @optionsParsed = JSON.parse(@options)
        catch err
          console.warn "Could not JSON.parse options attribute: #{err}"
          @optionsParsed = {}

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
