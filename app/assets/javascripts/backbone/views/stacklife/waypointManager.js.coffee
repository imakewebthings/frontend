jQuery.waypoints.settings.scrollThrottle = 10

Backbone.on 'stacklife:init', ->
  $content = $ '#content'
  $stacklifeContainer = $ '.stacklife-container'
  $stickyWrapper = $ '.waypoint-wrapper'
  $footer = $ '.container > footer'

  $content.waypoint
    handler: (direction) ->
      $stickyWrapper.toggleClass 'stuck', direction is 'down'
    offset: -> -parseInt $stacklifeContainer.css('borderTopWidth'), 10

  $footer.waypoint
    handler: (direction) ->
      $stickyWrapper.toggleClass 'unstuck', direction is 'down'
      $stickyWrapper.toggleClass 'stuck', direction is 'up'
    offset: ->
      $.waypoints('viewportHeight') + 30

