"use strict"

Test = require("zenrequest").Test

module.exports = ->
  tasks = []
  tasks.push _getIcon site for site in ZENrequest.sites
  tasks


# -- Promises ------------------------------------------------------------------
_getIcon = (domain) -> ->
  Test "POST", "scrape/icon", site: domain, null, "Get icon from #{domain}"
