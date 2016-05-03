# this plugin require @jQuery, and @widget from jQuery-ui and hammerJs
do ($ = jQuery) ->
  $.widget 'managIt.slideOut',
    options :
      menuWidth       : 240
      outDuration     : 200
      inDuration      : 300
      stikOn          : 1280
      edge            : 'left'
      closeOnSelect   : false
      easing          : 'easeOutQuad'
      classes         :
        opened : 'slide-out-opend'
        closed : 'slide-out-closed'
        opening : 'slide-out-opening'

    _create : ->
      that = this

      @menu = $ "##{@element.data 'activates'}"
      @overlay = $ '<div class=overlay></div>'
        .attr 'data-related-to', "##{@menu.attr 'id'}"
        .bind 'show', ->
          console.log 'hi showed', this 
        
      @overlay.trigger 'show'

      @_hlps.$body.append @overlay
      
      if not (@options.edge is 'left' or @options.edge is 'right')
        console.warn "undefiend slide out edge: #{@options.edge}"
        return false
      ### set menu styling ###
      do (that = this)->
        styling = {
          width: that.options.menuWidth
        }
        styling[that.options.edge] = -1 * that.options.menuWidth
        
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
          
          

      @_on @element,
        'click' : ->
          @toggle()
      @_on @overlay,
        'click' : ->
          @close()
      


      ### on resize the window ###
      @_on window,
        'resize' : (e)->
          if @isOpen()
            if window.innerWidth >= @.options.stikOn
              @_overlay 'hide'
            else
              @_overlay 'show'
        
        
        
    _hlps : 
      opened : false
      overlayIsVisable : false
      isAnimating : false
      $body  : $ 'body'

    _isURL : (el) ->
      url = el.getAttribute 'href'
      if url and url.trim()[0] isnt '#' then true else false

    isOpen : ->
      return @_hlps.opened

    _menu : (order)->      
      tglMenu = (animation, removedClass, addedClass,duration,status) =>
        @menu.removeClass(removedClass).addClass(@options.classes.opening).velocity animation,
          'duration' : duration
          'queue' : false
          'easing': @options.easing
          'complete' : =>
            @menu.removeClass(@options.classes.opening).addClass(addedClass)
            @_hlps.opened = status
      
      
      if order is 'show'
        tglMenu {"#{@options.edge}" : 0}, @options.classes.closed, @options.classes.opened, @options.inDuration, true
      
      else if order is 'hide'
        tglMenu {"#{@options.edge}" : -1 * @options.menuWidth}, @options.classes.opened, @options.classes.closed, @options.outDuration, false

      this
    _overlay : (order)->
      tglOverlay = (animation, duration,status) =>
        @overlay.velocity animation,
          'duration' : duration
          'queue' : false
          'easing': @options.easing
          'begin' : =>
            @_hlps.overlayIsVisable = status
          
      if @_hlps.overlayIsVisable is false and order is 'show'
        tglOverlay 'fadeIn', @options.inDuration, true
      else if @_hlps.overlayIsVisable is true and order is 'hide'
        tglOverlay 'fadeOut', @options.outDuration, false
    
    
    
    
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
      ### add classes to the body ###
      @_hlps.$body.addClass("slide-out-opend ##{@menu.attr 'id'}")
      ### animating the opening of the menu ###
      # @menu.removeClass(@options.classes.closed).addClass(@options.classes.opening).velocity {"#{@options.edge}": 0},
      #   duration : @options.inDuration
      #   queue : false
      #   easing: @options.easing
      #   complete : ->
      #     that = that
      #     that.menu.removeClass(that.options.classes.opening).addClass(that.options.classes.open)
      #     that._hlps.opened = true
      #     # animationState.menuState = true
      #     # isAnimationComplete animationState
      @_menu 'show'  
      
      @_overlay 'show'  
      # @overlay.velocity {opacity: 1},
      #   duration : @options.inDuration
      #   queue : false
      #   display : 'block'
      #   easing: @options.easing
      #   complete : ->
      #     # animationState.overlayState = true
      #     # isAnimationComplete animationState

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

      # ### hide the overlay ###
      # @overlay.velocity {opacity:0},
      #   duration : @options.outDuration
      #   queue : false
      #   easing: @options.easing
      #   display : 'none'
      #   complete : ->
      #     $(this).hide()

      @_overlay 'hide'
      # ### hide the menu ###
      # @menu.velocity {"#{@options.edge}": -1 * @options.menuWidth},
      #   duration : @options.outDuration
      #   queue : false
      #   easing: @options.easing
      #   complete : ->
      #     that._hlps.opened = false
      @_menu 'hide'
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
    window.testing = $('#sidenav-init-btn').slideOut()