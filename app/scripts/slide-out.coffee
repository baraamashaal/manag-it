# this plugin require @jQuery, and @widget from jQuery-ui and hammerJs
do ($ = jQuery) ->
  $.widget 'managIt.slideOut',
    options :
      menuWidth       : 240
      outDuration     : 200
      inDuration      : 300
      edge            : 'left'
      closeOnSelect   : false
      easing          : 'easeOutQuad'
      classes         :
        opened : 'slide-out-opend'
        closed : 'slide-out-closed'
        opening : 'slide-out-opening'

    _create : ->
      @menu = $ "##{@element.data 'activates'}"
      @overlay = $ '<div class=overlay></div>'

      @_hlps.$body.append @overlay
      
      if not (@options.edge is 'left' or @options.edge is 'right')
        console.warn "undefiend slide out edge: #{@options.edge}"
        return false
      ### set menu styling ###
      do (that = this)->
        styling = {
          width: that.options.menuWidth
        }
        styling[that.options.edge] = 0
        
        that.menu.css styling
        
      
      
      ### enable touch ###
      if @options.enableTouch is true
        @touch

      ### check if there is needs for the click listener ###
      if @options.closeOnSelect is true or typeof @options.onSelect is 'function'
        ### add click listener ###
        @_on @menu,
          'click' : (e)->
            ### close the menu if closeOnSelect option is true ***useful for ajax webapp ###
            if @options.closeOnSelect is true and e.target is 'a' and @_isURL e.target
              @close

            ### fire custom function on select any item on the menu ###
            if typeof @options.onSelect == 'function'
              @options.onSelect.call @menu, e
          
          

      @_on this.element,
        'click' : ->
          @toggle()
         
        
    _hlps : 
      opened : false
      isAnimating : false
      $body  : $ 'body'

    _isURL : (el) ->
      url = el.getAttribute 'href'
      if url and url.trim()[0] isnt '#' then true else false

    isOpen : ->
      return @_hlps.opened
    
    open : ->
      ### do nothing if it's already opened ###
      if @isOpen() then return false
      that = this     
      
      ### fire custom function before opening the menu  ###
      if typeof @options.beforeOpen is 'function'
        @options.beforeOpen.call(@menu)

      ### disable Scrolling ###
      if @options.disableScrolling is true
        @_hlps.$body.css 'overflow', 'hidden'

      ### animating the opening of the menu ###
      @menu.removeClass(@options.classes.closed).addClass(@options.classes.opening).velocity {"#{@options.edge}": 0},
        duration : @options.inDuration
        queue : false
        easing: @options.easing
        complete : ->
          that = that
          that.menu.removeClass(that.options.classes.opening).addClass(that.options.classes.open)
          that._hlps.opened = true
          # animationState.menuState = true
          # isAnimationComplete animationState
        
      @overlay.velocity {opacity: 1},
        duration : @options.inDuration
        queue : false
        easing: @options.easing
        complete : ->
          # animationState.overlayState = true
          # isAnimationComplete animationState

      ### fire custom function after opening the menu  ###
      if typeof @options.afterOpen is 'function'
        @options.afterOpen.call(@menu)

      return this

    close : ->
      console.log 'close()'
      that = this
      ### do nothing if it's already closed ###
      if not @isOpen() then return false

      ### fire custom function before closeing the menu  ###
      if typeof @options.beforeClose is 'function'
        @options.beforeClose.call(@menu)

      ### eenable scrolling ###
      @_hlps.$body.css 'overflow', ''

      ### hide the overlay ###
      @overlay.velocity {opacity:0},
        duration : @options.outDuration
        queue : false
        easing: @options.easing
        complete : ->
          $(this).hide()
      ### hide the menu ###
      @menu.velocity {"#{@options.edge}": -1 * @options.menuWidth},
        duration : @options.outDuration
        queue : false
        easing: @options.easing
        complete : ->
          that._hlps.opened = false
        
      ### fire custom function After closeing the menu  ###
      if typeof @options.afterClose is 'function'
        @options.afterClose.call(@menu)

        return this
    toggle : ->
      console.log this      
      if @isOpen() is true then @close() else @open()
      return this
    
    
    touch : ->
      touchArea = $  "<div class='touch-area' style='#{if @options.edge is 'right' then 'right' else 'left'}:0'></div>"
      
      @_hlps.$body.append touchArea
      

    
      
    
  # testing
  $ ->
    $('#sidenav-init-btn').slideOut()