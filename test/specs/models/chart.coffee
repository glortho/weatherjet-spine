describe 'Chart', ->
  Chart = null
  
  beforeEach ->
    class Chart extends Spine.Model
      @configure 'Chart'
  
  it 'can noop', ->
    