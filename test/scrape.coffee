"use strict"

Test = require("zenrequest").Test

module.exports = ->
  tasks = []
  tasks.push _getIcon ZENrequest.domains[0]
  tasks


# -- Promises ------------------------------------------------------------------
_getIcon = (domain) -> ->
  Test "POST", "scrape/icon", domain: domain, null, "Get icon from #{domain}"
