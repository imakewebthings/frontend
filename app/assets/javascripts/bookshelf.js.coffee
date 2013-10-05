jQuery ->
  return unless $('.stacklife-container').length
  Backbone.trigger 'stacklife:init'
  new DPLA.Routers.StacklifeRouter
  Backbone.history.start pushState: false, root: '/stacklife'
