parseQueryString = (queryString) ->
  params = {}
  if queryString
    mapped = _.map decodeURIComponent(queryString).split(/&/g), (el, i) ->
      aux = el.split '='
      obj = {}
      if aux.length >= 1
        val = undefined
        if aux.length == 2
          val = aux[1]
        obj[aux[0]] = val
      obj
    _.each mapped, (obj) -> _.extend params, obj
  params

createStackView = _.once ->
  params = parseQueryString window.location.search
  new DPLA.Views.Stacklife.Stack
    url: 'http://dpla-life-service-dev.herokuapp.com/search'
    jsonp: true
    query: (params['q'] ? 'science')
    ribbon: ''
    search_type: 'keyword'

class DPLA.Routers.StacklifeRouter extends Backbone.Router
  routes:
    '':    'stackView'
    ':id': 'bookPreviewView'

  stackView: ->
    createStackView()
    Backbone.trigger 'stacklife:previewunload'

  bookPreviewView: (id) ->
    createStackView()
    Backbone.trigger 'stacklife:previewload', id


