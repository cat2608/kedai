"use strict"

cheerio = require "cheerio"
scrape  = require "request"

module.exports = (server) ->

  server.get "/scrape/icon", (request, response) ->
    icon = []
    scrape request.parameters.domain, (error, result, html) ->
      return response.badRequest() if error

      $ = cheerio.load(html)
      $("link").each (i, element) ->
        icon.push($(this).attr('href')) if new RegExp("icon").test($(this).attr('rel'))
      response.json icon: icon
