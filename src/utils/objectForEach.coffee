'use strict'

###*
 * objectForEach
 *
 * @param  {Object} object
 * @param  {Function} func
 * @returns {void}
###
module.exports = (object, func) ->
  for own key, val of object then func(val, key)
