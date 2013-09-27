Backbone.on 'stacklife:init', ->
  class DPLA.Views.Stacklife.Relateds extends DPLA.Views.Stacklife.Base
    el: '.book-relateds'
    template: JST['backbone/templates/stacklife/relateds']

    initialize: (options) ->
      super options
      @collection = new Backbone.Collection
      @collection.on 'reset', _.bind(@redraw, this)
      @loadCollection()

    undelegateEvents: ->
      $(window).off 'resize.relateds'
      super

    render: ->
      super
      @$('.dpla-relateds').imagesLoaded _.bind(@masonize, @)
      $(window).on 'resize.relateds', _.debounce(_.bind(@handleResize, @), 200)
      @resizeToWindow()

    masonize: ->
      @$('.dpla-relateds').masonry { itemSelector: '.dpla-related-item' }

    loadCollection: ->
      params = @params()
      if params
        @collection.url = "/stacklife?#{$.param(params)}"
        @collection.fetch()
      else
        @collection.update []

    params: ->
      subjects = @options.bookModel.get('sourceResource').subject
      return unless subjects?
      subjectFilter = (subject) ->
        jQuery.trim(subject.name.replace(/\W/g, ' ').replace(/(\s)+/g, ' '))
      {
        q: _.map(subjects, subjectFilter).join(' OR '),
        'type[]': 'image'
      }

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

