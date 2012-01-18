Spine = require('spine')

class WeatherQuery extends Spine.Model
	@configure 'WeatherQuery', 'query', 'processor'

	defaults: {
  	xhr: {
	  	urls: {
	  		locations: 'http://autocomplete.wunderground.com/aq?query={query}&format=JSON',
	  		weather: 'http://api.wunderground.com/api/19965ec909572167/geolookup/conditions/forecast7day/q/{query}.json'
	  	},
	  	options: {
	  		dataType: 'jsonp',
	  		type: 'post'
	  	}
	  }
	}

	qapi: ->
		if @query == 'local' and navigator.geolocation
			navigator.geolocation.getCurrentPosition (pos) =>
				@query = pos.coords.latitude + ',' + pos.coords.longitude
				@send()
		else
			@send()
		
	send: =>
		@query = if @query == 'local' then 'autoip' else @query
		settings = $.extend({}, @defaults.xhr.options)
		settings.url = @defaults.xhr.urls.weather.replace('{query}', @query)
		$.ajax(settings).done(@processor)
		#$.getJSON('./data.json', @processor)

module.exports = WeatherQuery
