"use strict"

cheerio = require "cheerio"
fs      = require "fs"
http    = require "http"
scrape  = require "request"

ROOT          = "#{__dirname}/../assets/images/icon.png"
last_modified = null

module.exports = (server) ->

  ###
   * Scrape site searching for favicon and write to system
   * @param   {String} site
   * @return  {Object} Response
  ###
  server.post "/scrape/icon", (request, response) ->
    scrape request.parameters.site, (error, result, html) ->
      icon = null
      return response.badRequest() if error
      if fs.existsSync ROOT
        cache_modified = fs.statSync(ROOT).mtime
        if last_modified? and __time(last_modified) < __time(cache_modified)
          return response.ok()
        else
          $ = cheerio.load(html)
          $("link").each (i, element) ->
            icon = ($(this).attr('href')) if new RegExp("icon").test($(this).attr('rel'))
          if icon?
            icon = result.request.uri.href + icon if not new RegExp("http").test icon
            file = fs.createWriteStream ROOT
            http.get icon, (result) ->
              last_modified = result.headers["last-modified"]
              result.pipe file
              response.ok()

# -- Private methods -----------------------------------------------------------
__time = (value) -> (new Date(value)).getTime()
