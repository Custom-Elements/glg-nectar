#glg-nectar
*TODO* tell me all about your element.

    _ = require('../node_modules/lodash/dist/lodash.js')
    
    Polymer 'glg-nectar',

##Events
*TODO* describe the custom event `name` and `detail` that are fired.

##Attributes and Change Handlers

##Methods

##Event Handlers

      triggerChanged: (oldVal,newVal) ->
        @removeEventListener oldVal, @loadResults if oldVal
        @addEventListener newVal, @loadResults

      entitiesChanged: ->
        e = @entities
        e = JSON.parse(e) if e[0] is '['
        @entitiesParsed = e        

      loadResults: (evt) ->
        if evt.detail.value.length > 0 
          query = 
            entity: @entitiesParsed, 
            query: evt.detail.value
            options:  
              howMany: @limit
              interleave: false

          @$.socket.send query, (response) =>
            @results = response.results
            @resultset = _.map response.results, (results,type) -> { type, results }
            @fire 'results', { query: query, results: @results, resultset: @resultset }
        else 
          query=
            entity: null,
            query: "",
            options:
              howMany: 0
              interleave: false

          @results = null
          @resultset = []
          @fire 'results', { query: query, results: @results, resultset: @resultset }
          