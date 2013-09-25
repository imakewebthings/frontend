Backbone.on 'stacklife:init', ->
  currentPreview = null

  class DPLA.Views.Stacklife.BookPreview extends DPLA.Views.Stacklife.Base
    el: '.preview-wrapper'
    template: JST['backbone/templates/stacklife/bookPreview']

    render: ->
      super
      @subviews.push new DPLA.Views.Stacklife.Relateds
        el: '.book-relateds'
        bookModel: @model
      @$el.addClass 'book-loaded'

  Backbone.on 'stacklife:previewload', (id) ->
    book = new DPLA.Models.StacklifeBook { id: id }

    book.fetch
      success: (model, response, options) ->
        currentPreview.clear() if currentPreview && currentPreview.model
        currentPreview = new DPLA.Views.Stacklife.BookPreview { model: model }

      error: (model, xhr, options) ->
        # appNotify.notify
        #   type: 'error'
        #   message: 'Something went wrong trying to load that book.'

  Backbone.on 'stacklife:previewunload', ->
    if currentPreview
      currentPreview.$el.removeClass 'book-loaded'
      currentPreview.clear()
    currentPreview = null