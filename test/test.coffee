assert = require 'power-assert'

Router = require '..'

before (done) ->
  global.location or= {}
  done()

describe 'Router', ->

  describe 'constructor', ->
    it 'case1', ->
      routes = '/': ->

      router = new Router routes

      assert router instanceof Router
      assert.deepEqual router.routes, routes
      assert.deepEqual router.config, {rootPath: ''}

  describe 'configure', ->
    it 'case1', ->
      config = rootPath: '/path/to'

      router = new Router()
      router.configure config
      assert.deepEqual router.config, config

  describe 'run', ->
    it 'case / => /index.html', ->
      global.location.pathname = '/index.html'

      expected = false

      routes =
        '/': -> expected = true
        '/page/': [
          -> expected = false
          -> expected = false
        ]
        '/page.html': -> expected = false

      router = new Router routes
      router.run()
      assert expected

    it 'case / => /', ->
      global.location.pathname = '/'

      expected = false

      routes =
        '/': -> expected = true
        '/page/': [
          -> expected = false
          -> expected = false
        ]
        '/page.html': -> expected = false

      router = new Router routes
      router.run()
      assert expected

    it 'case /page/', ->
      global.location.pathname = '/page/'

      expected1 = false
      expected2 = false

      routes =
        '/page/': [
          -> expected1 = true
          -> expected2 = true
        ]

      router = new Router routes
      router.run()
      assert(expected1 and expected2)

    it 'case /page.html', ->
      global.location.pathname = '/page.html'

      expected = false

      routes =
        '/page.html': -> expected = true

      router = new Router routes
      router.run()
      assert expected

    it 'case /path/to/page.html', ->
      global.location.pathname = '/path/to/page.html'

      expected = false

      routes =
        '/path/to/page.html': -> expected = true

      router = new Router routes
      router.run()
      assert expected

  describe 'addRoute', ->
    it 'case1', ->
      global.location.pathname = '/'

      expected = false
      router = new Router()

      router.addRoute '/', -> expected = true

      router.run()
      assert expected

  describe 'removeRoute', ->
    it 'case1', ->
      global.location.pathname = '/'

      expected = true
      router = new Router '/': -> expected = false

      router.removeRoute '/'

      router.run()
      assert expected
