Backbone.on 'stacklife:init', ->
  class DPLA.Views.Stacklife.InfoPanel extends DPLA.Views.Stacklife.Base
    el: '.stacklife-container'
    template: JST['backbone/templates/stacklife/infoPanel']

    events:
      'click .toggle-infopanel': 'toggle'

    render: ->
      @$('.stack-wrapper').before @template()

    show: ->
      @$el.addClass 'infopanel-on'

    hide: ->
      @$el.removeClass 'infopanel-on'

    toggle: (event) ->
      @$el.toggleClass 'infopanel-on'
      event.preventDefault()

  infoPanel = new DPLA.Views.Stacklife.InfoPanel

  Backbone.on 'stacklife:previewload', ->
    infoPanel.hide()
  Backbone.on 'stacklife:previewunload', ->
    infoPanel.show()
