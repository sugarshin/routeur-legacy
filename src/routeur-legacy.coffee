###!
 * @license routeur-legacy
 * (c) sugarshin
 * License: MIT
###

'use strict'

globToRegexp = require 'glob-to-regexp'
assign = require 'object-assign'
omit = require 'object.omit'
extRegex = require 'ext-regex'
arrayForeach = require 'array-foreach'
isArray = require 'isarray'

objectForEach = require './util/objectForEach'
indexRegex = require './util/indexRegex'
isFunction = require './util/isFunction'

module.exports =
class Routeur

  constructor: (@routes = {}, config) ->
    @config = assign {rootPath: ''}, config

  run: (currentPathName = location.pathname or '') ->
    objectForEach @routes, (actionOrActions, pathName) =>
      globPath = @_getGlobPath @config.rootPath, pathName
      regexp = globToRegexp globPath, {extended: true}

      if regexp.test(currentPathName)
        if isFunction(actionOrActions)
          actionOrActions()
        else if isArray(actionOrActions)
          arrayForeach actionOrActions, (action) -> action()

  configure: (config) ->
    @config = assign {}, @config, config
    return this

  addRoute: (pathName, actionOrActions) ->
    @routes[pathName] = actionOrActions
    return this

  removeRoute: (pathName) ->
    @routes = omit @routes, pathName
    return this

  _getGlobPath: (rootPath, pathName) ->
    if extRegex().test(pathName)
      return "#{rootPath}#{pathName}"

    if indexRegex().test(pathName)
      return "#{rootPath}#{pathName}{,index.html}"

    return "#{rootPath}#{pathName}{/,/index.html}"
