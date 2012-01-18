Spine = require('spine')
# Highcharts = require('lib/highcharts.js')

class Chart extends Spine.Model
	@configure 'Chart', 'data'

	render: =>
		Highcharts.setOptions(colors: ['#ED561B', '#058DC7'])
		days = []
		highs = []
		lows = []
		chart_settings = $.extend({}, @defaults)

		for i in [0..4]
			nug = @data[i]
			days.push(nug.date.weekday_short)
			highs.push(parseInt(nug.high.fahrenheit, 10))
			lows.push(parseInt(nug.low.fahrenheit, 10))

		series = [highs, lows]

		chart_settings.legend.backgroundColor = (Highcharts.theme and Highcharts.theme.legendBackgroundColorSolid) or 'white'
		chart_settings.xAxis.categories = days
		for i in [0..(series.length - 1)]
			chart_settings.series[i].data = series[i]
		
		new Highcharts.Chart chart_settings

	defaults: {
		chart: { renderTo: 'forecast-chart', defaultSeriesType: 'column' },
		title: { text: '5-Day Forecast' },
		xAxis: { categories: '' },
		yAxis: { title: { text: 'Temperature' } },
		legend: {
			align: 'right',
			x: -100,
			verticalAlign: 'top',
			y: 20,
			floating: true,
			backgroundColor: '',
			borderColor: '#CCC',
			borderWidth: 1,
			shadow: false
		},
		plotOptions: {
			column: {
				pointPadding: 0.2,
				borderWidth: 0,
				dataLabels: { enabled: true }
			}
		},
		series: [{ name: 'High', data: '' }, { name: 'Low', data: '' }]
	}
  
module.exports = Chart
