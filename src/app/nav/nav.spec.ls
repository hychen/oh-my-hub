expect = chai.expect
describe 'Nav module', ->
  beforeEach ->
    module 'OhMyHub.nav'
  describe "NavFilter service", -> ``it``
    .. 'indicats current applied conditions.', (done) -> 
      NavFilters <- inject 
      filters = NavFilters.get!
      expect filters.indicators.length .to.eq 0
      NavFilters.add 'category', 'Attr1'
      NavFilters.add 'category', 'Attr2'
      NavFilters.add 'type', 'Attr3'
      expect filters.indicators .to.deep.eq [
        * name: 'Attr1'
          category: 'category'
        * name: 'Attr2'
          category: 'category'
        * name: 'Attr3'
          category: 'type'
      ]
      NavFilters.del 'category', 'Attr1'
      expect filters.indicators .to.deep.eq [ 
        * name: 'Attr2'
          category: 'category'
        * name: 'Attr3'
          category: 'type'
      ]
      NavFilters.del 'category', 'Attr2'
      NavFilters.del 'type', 'Attr3'
      expect filters.indicators.length .to.eq 0
      expect filters.attributes .to.deep.eq {}
      done!
  describe 'NavFilters.add', -> ``it``
    .. "should catch invalid arguments.", (done) ->
      NavFilters <- inject
      expect (-> NavFilters.add null, 'condition is given') .to.throw Error
      expect (-> NavFilters.add 'category is given', null) .to.throw Error
      expect NavFilters.get!indicators.length .to.eq 0
      expect NavFilters.get!attributes .to.deep.eq {}
      done!
    .. "should catch duplicate conditions.", (done) ->
      NavFilters <- inject 
      NavFilters.add "category", "Attr1"
      expect (-> NavFilters.add "category", "Attr1") .to.throw Error
      expect NavFilters.get!indicators.length .to.eq 1
      done!
  describe 'NavFilters.del', -> ``it``
    .. "should catch invalid arguments.", (done) -> 
      NavFilters <- inject
      expect (-> NavFilters.del null, 'condition is given') .to.throw Error
      expect (-> NavFilters.del 'category is given', null) .to.throw Error
      done!
    .. "should catch removing a condition from a empty filters.", (done) ->
      NavFilters <- inject
      expect (-> NavFilters.del "category", "Attr1") .to.throw Error
      done!
    
