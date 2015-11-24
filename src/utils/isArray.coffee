'use strict'

###*
 * isArray
 *
 * @param {any} value
 * @returns {Boolean}
###
module.exports = (value) ->
  Object.prototype.toString.call(value) is '[object Array]'
