Backbone.on 'stacklife:init', ->
  class DPLA.Models.StacklifeBook extends Backbone.Model
    urlRoot: 'http://dpla-life-service-dev.herokuapp.com/books'