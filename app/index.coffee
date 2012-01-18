require('lib/setup')

Spine = require('spine')
WeatherSheets = require('controllers/weathersheets')

class App extends Spine.Controller
  constructor: ->
    super

    @weathersheets = new WeatherSheets
    @append @weathersheets
   	Spine.Route.setup()

module.exports = App
    
