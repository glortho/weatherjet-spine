describe 'WeatherSheet', ->
  WeatherSheet = null
  
  beforeEach ->
    class WeatherSheet extends Spine.Model
      @configure 'WeatherSheet'
  
  it 'can noop', ->
    