# Promises to get stuff

    module.exports = utils =

## getUrl
getUrl takes a single paramater which can be either a string (the url)
or an object, specifing url and timeout: {url:'http://myurl.com',timeout:1000}

      getJSONUrl: (url, timeout) ->
        new Promise (resolve,reject) ->
          request = new XMLHttpRequest()
          .async = false
          .withCredentials = true
          .responseType = 'json'
          .timeout = timeout if timeout?
          .ontimeout = () ->
            reject new Error "utils.getUrl timed out fetching #{url}"
          request.open 'GET', url
          request.send()
          if request.status is '200'
            console.log "response received from #{url}"
            resolve response
          else
            reject new Error "utils.getUrl failed: #{response.statusText}"

## fetchEpiResults
Hits an epiquery url and returns the results if there are any

      fetchEpiResults: (url, timeout) ->
        new Promise (resolve, reject) ->
          #Fetch and then process results
          console.log "Fetching #{url}"
          @getJSONUrl url, timeout
          .then (output) ->
            if Array.isArray(output)
              resolve if Array.isArray(output[output.length-1]) then output[output.length-1] else output
            else
              reject new Error("fetchEpiResults received unexpected result format")
          .then undefined, (err) ->
            reject new Error("fetchEpiResults failed: #{err}")

