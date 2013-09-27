Backbone.on 'stacklife:init', ->
  class DPLA.Models.StacklifeBook extends Backbone.Model
    urlRoot: '/item'