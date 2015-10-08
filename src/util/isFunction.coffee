###*
 * isFunction
 *
 * @return  {Boolean}
###

'use strict'

toString = Object.prototype.toString

module.exports = isFunction = (value) ->
  toString.call(value) is '[object Function]'
