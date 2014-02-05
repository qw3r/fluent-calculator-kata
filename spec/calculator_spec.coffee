class Calculator
  @Calc = (number) ->
    new Calculator number

  constructor: (@number) ->
    @states = [@number]
    @redoStates = []

  toInt: ->
    @states[@states.length - 1]

  Plus: (number) ->
    @states.push @number += number
    @

  Minus: (number) ->
    @states.push @number -= number
    @

  Undo: ->
    @redoStates.push @states.pop() if @states.length
    @

  Redo: ->
    @states.push @redoStates.pop() if @redoStates.length
    @

  Save: ->
    new Calculator @toInt()




describe 'Calculator', ->

  beforeEach ->
    @calc = Calculator.Calc(10)


  describe '.Calc', ->
    it 'sets initial number', ->
      expect(@calc.toInt()).toEqual 10



  describe '.Plus', ->
    it 'increases the initial number', ->
      expect(@calc.Plus(5).toInt()).toEqual 15



  describe '.Minus', ->
    it 'decreases the initial number', ->
      expect(@calc.Minus(5).toInt()).toEqual 5



  describe '.Undo', ->
    it 'undos the previous operation', ->
      expect(@calc.Minus(5).Undo().toInt()).toEqual 10


  describe '.Redo', ->
    it 'redos the previous undo', ->
      expect(@calc.Minus(5).Undo().Redo().toInt()).toEqual 5


  describe '.Save', ->
    it 'saves the current value, cannot redo earlier states', ->
      expect(@calc.Minus(5).Undo().Save().Redo().toInt()).toEqual 10

