Backbone.on 'stacklife:init', ->
  class DPLA.Views.Stacklife.Relateds extends DPLA.Views.Stacklife.Base
    el: '.book-relateds'
    template: JST['backbone/templates/stacklife/relateds']

    initialize: (options) ->
      super options
      @model = new Backbone.Model
      @model.on 'change', _.bind(@redraw, this)
      @loadModel()
      $(window).on 'resize.relateds', _.debounce(_.bind(@handleResize, @), 200)

    undelegateEvents: ->
      $(window).off 'resize.relateds'
      super

    render: ->
      super
      @$('.dpla-relateds').imagesLoaded _.bind(@masonize, @)
      @resizeToWindow()

    masonize: ->
      @$('.dpla-relateds').masonry { itemSelector: '.dpla-related-item' }

    loadModel: ->
      params = @params()
      if params
        @model.url = "http://dpla-life-service-dev.herokuapp.com/dpla-items?#{$.param(params)}"
        @model.fetch()
      else
        @model.set 'docs', []

    params: ->
      subjects = @options.bookModel.get('sourceResource').subject
      return unless subjects?
      subjectFilter = (subject) ->
        jQuery.trim(subject.name.replace(/\W/g, ' ').replace(/(\s)+/g, ' '))
      { q: _.map(subjects, subjectFilter).join(' OR ') }

    handleResize: ->
      @refreshMasonryLayout()
      @resizeToWindow()

    refreshMasonryLayout: ->
      @$('.dpla-relateds').masonry()

    resizeToWindow: ->
      return unless @$el.parent().length
      $module = @$el.children('.module')
      moduleTop = $module.offset().top
      previewTop = @$el.closest('.preview-wrapper').offset().top
      winHeight = $(window).height()
      $module.css 'height', (winHeight - (moduleTop - previewTop))

