###*
 * objectForEach
 *
 * @param  {Object} object
 * @param  {Function} callback
 * @param  {Any} context = global
###

'use strict'

keys = require 'object-keys'
arrayForeach = require 'array-foreach'

module.exports = objectForEach = (object, callback, context = global) ->
  arrayForeach keys(object), (key, i) ->
    callback.call context, object[key], key, i, object
