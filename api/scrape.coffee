"use strict"


module.exports = (server) ->

  server.get "/scrape/icon", (request, response) ->
    response.ok()
