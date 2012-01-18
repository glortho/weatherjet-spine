Spine = require('spine')
WeatherQuery = require('models/weatherquery')
Chart = require('models/chart')

class WeatherSheets extends Spine.Controller
  className: 'wejet'

  elements:
    '#search': 'search'

  events:
    'submit form': 'user_query'

  constructor: ->
    super

    @bind 'data-ready', 'show'
    @routes
    	'/q/:query': (params) -> @api_query(params)

    @navigate('/q/local', true)

  api_query: (params) ->
    that = @
    @query = params.query
    weather = new WeatherQuery(query: @query, processor: @process)
    weather.qapi()

  user_query: ->
    query = @search.val()
    @navigate("/q/#{query}")
    false

  process: (data) =>
    @location = data.location
    @forecast = data.forecast.simpleforecast.forecastday
    @conditions = data.current_observation
    @render()

  render: =>
    @html require('views/weathersheets')(@)
    chart = new Chart(data: @forecast)
    chart.render()
    
  helper:

    location: (l) ->
      l.city + ', ' + if l.state.length then l.state + " (#{l.zip})" else l.country_name
    
    forecast: (f) ->
      output = ""
      for i in [0..4]
        output += "<span><img title='#{f[i].pop} chance of precip' src='#{f[i].icon_url}'/></span>"
      output

    conditions: (c) ->
      img = "<img src='#{c.icon_url}' alt='icon-now' class='icon' id='icon-now' style='float: left; margin-right: 10px;'>"
      txt = "<div>#{c.temp_f} F, #{c.weather}</div>"
      img + txt
 
module.exports = WeatherSheets
