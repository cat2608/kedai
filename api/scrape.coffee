"use strict"

cheerio = require "cheerio"
fs      = require "fs"
http    = require "http"
scrape  = require "request"

module.exports = (server) ->

  server.post "/scrape/icon", (request, response) ->
    icon = null
    scrape request.parameters.site, (error, result, html) ->
      return response.badRequest() if error

      $ = cheerio.load(html)
      $("link").each (i, element) ->
        icon = ($(this).attr('href')) if new RegExp("icon").test($(this).attr('rel'))
      if icon?
        icon = result.request.uri.href + icon if not new RegExp("http").test icon
        file = fs.createWriteStream "#{__dirname}/../assets/images/icon.png"

        http.get icon, (result) -> result.pipe file

      response.ok()
