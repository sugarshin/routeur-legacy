###!
 * @license routeur-legacy
 * (c) sugarshin
 * License: MIT
###

'use strict'

globToRegexp = require 'glob-to-regexp'

objectForEach = require './utils/objectForEach'
isArray = require './utils/isArray'
indexRegex = require './utils/indexRegex'
extRegex = require './utils/extRegex'

module.exports =
class Routeur

  constructor: (@_routes = {}, @_config = { rootPath: '' }) ->

  run: (currentPathName = location.pathname or '') ->
    objectForEach @_routes, (action, pathName) =>
      globPath = @_getGlobPath pathName
      regexp = globToRegexp globPath, { extended: true }
      @_createFinalAction(action)() if regexp.test(currentPathName)

  route: (pathName, action) ->
    if typeof action isnt 'function' then throw new TypeError "#{action} is not a function"
    @_routes[pathName] = action

  _createFinalAction: (action) ->
    if isArray(action) then ->
      for func in action then func()
    else
      action

  _getGlobPath: (pathName) ->
    if indexRegex().test(pathName)
      return "#{@_config.rootPath}#{pathName}{,index.*}"

    if extRegex().test(pathName)
      return "#{@_config.rootPath}#{pathName}"

    return "#{@_config.rootPath}#{pathName}{/,/index.*}"
