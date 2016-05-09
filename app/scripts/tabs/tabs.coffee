# do ($ = jQuery) ->
#   $.widget 'managIt.tabs',

#     ### plugin options ###
#     options :
#       justify : false
#       dir : 'ltr'

#     ### constructor ###
#     _create : ->
#       @element.wrap '<div class="tabs-wrapper"></div>'
#       tabs = @element.find '.tab'
      
#       links = tabs.children 'a'
      
#       active = do ->
#         # items = links.filter '[href=#\' + location.hash + \''

#         items = links.filter "[href='"+location.hash+"']"
        
#         if items.length
#           return items.first().parent()

#         items = tabs.filter('.active')
        
#         if items.length
#           return items.first()

#         return tabs.first()
      
#       tabs.removeClass 'active'

#       active.addClass 'active'
      
#       oldIndex = null
#       currentIndex = tabs.index active

#       # indicator = $ '<div class="indicator"></div>'
#       #   .css
#       #     left:active.postion().left
#       #     right : active.postion().right
#       indicator = do (_this = this)->
#         actvPos = do ->
#           parentRect = _this.element[0].getBoundingClientRect()
#           elemRect = active[0].getBoundingClientRect()
#           console.log parentRect
#           console.log elemRect
#           return elemRect.left - parentRect.left
        
#         console.log actvPos
#         console.log active.position().left
        
        
        
#         return $ "<div class='tabs-indicator' style='left:#{actvPos}px;right:#{_this.element[0].getBoundingClientRect().width - (actvPos + active[0].getBoundingClientRect().width)}px'></div>"
#       element = @element[0]
#       console.log active.position()
#       new ResizeSensor element, =>
#         console.log 'ssss'
#         actvPos = active.position().left
#         indicator.css
#             left : actvPos
#             # right : @element.width() - (actvPos + active.width())
#             right : @element[0].getBoundingClientRect().width - (actvPos + active[0].getBoundingClientRect().width)
        
#       @element.append indicator

#       # @_on window,
#       #   'resize': ->
#       #     console.log @element.width()
#       #     console.log 'asasas'
          
#       #     actvPos = active.position().left
          
          
#       #     indicator.css
#       #       left : actvPos
#       #       # right : @element.width() - (actvPos + active.width())
#       #       right : @element[0].getBoundingClientRect().width - (actvPos + active[0].getBoundingClientRect().width)
#       console.log active

#       @_on @element,
#         'click .tab' : (e) ->
#           console.log active.position()
#           e.preventDefault()
#           $target = $ e.currentTarget
#           if $target.hasClass 'disabled active' then return false

#           active.removeClass 'active'
#           active = $target.addClass 'active'

#           oldIndex = currentIndex
#           currentIndex = tabs.index active

#           if currentIndex > oldIndex
#             console.log 'ssss'
#             # indicator.velocity({"right": $tabs_width - (($index + 1) * $tab_width)}, { duration: 300, queue: false, easing: 'easeOutQuad'});
#     _resize : ->
    
    
  
  
# $ ->
#   $('.tabs').tabs()
  





# do (jQuery = $) ->
#   $.widget 'managIt.tabs',
#     options :
#       justify : false
#       dir   : 'ltr'
#     ###*
#      * plugin constructor
#      * @return {object} jQuery 
#     ###
#     _create : () ->
#       ###*
#        * update plugin option
#       ###
#       @_updateOptions()

#       # ###*
#       #  * wrap the tabs header in a container
#       # ###
#       # @element.wrap '<div class="tabs-wrapper"></div>'
#       ###*
#        * tabs header
#        * @type {jQuery object}
#       ###
#       @tabs = @element.children '.tab'
#       # ###*
#       #  * tabs anchors
#       #  * @type {jQuery object}
#       # ###
#       # @links = @tabs.children 'a'
#       @lastActive = null
#       @active = @_setActiveTab()

#       ###*
#        * remove all active classes from all tabs except the @active tab
#       ###
#       @tabs.removeClass 'active'
#       @active.addClass 'active'
      
#       @panalsWrap = do (that = this) ->
#         wrapper = null
#         that.tabs.each ->
#           wrapper = $("##{this.getAttribute 'aria-controls'}").parent('.tabs-content').addClass('here we gooo')
#           if wrapper.length
#             return false
#           else
#             wrapper = null
        
#         return wrapper
      
#       @panels = @panalsWrap.children '.tab-panel'
#       @activePanel = @_setActivePanel()
#       ###*
#        * indexs are used to know position of the new @active tab is after the old one or not
#        * @oldIndex old index position of the @active tab
#        * @type {Number}
#        * @currentIndex the current position of the @active tab
#        * @type {Number}
#       ###
#       @oldIndex = null
#       @currentIndex = @tabs.index @active
#       ###*
#        * @active tab indicator
#        * @type {[jQuery object]}
#       ###
#       @indicator = $ "<div class='tabs-indicator'></div>"
      
#       ###*
#        * update the posision of the indicator
#       ###
#       @_updateIndicator()

#       ###*
#        * append the indicator to the tabs header
#       ###
#       @element.append @indicator


#       ###*
#        * watch for window resizing
#       ###
      
#       @_onResize()

#       @_onClick()

#       ###*
#        * get tabs content
#        * @param  {[type]} that =             this [description]
#        * @return {[type]}      [description]
#       ###
#       # @tabsContent = do (that = this) ->
#       #   tabsContent = $ that.element.attr 'data-content'
#       #   if tabsContent.length
#       #     return tabsContent
#       #   that.links.each ->
#       #     tabsContent = $(this.getAttribute 'href').parent '.tabs-content'
#       #     if tabsContent.length
#       #       return false
#       #   return tabsContent
#       # # console.log @tabsContent
#       # @_updatePanel()
      

#     ###*
#      * some global privte helpers 
#      * @type {Object}
#     ###
#     _ : {}
#     ###*
#      * update plugin option from the data-attribute in the html
#     ###
#     _updateOptions : ->
#       for opt of @options
#         if @options.hasOwnProperty opt
#           ###*
#            * transform camelCase to hyphenCase    
#            * @param  {String} AZ the capital 
#            * @return {String} string of the hyphenCase of the camelCase String
#           ###
#           hyphenOpt = opt.replace /[A-Z]/g, (AZ) ->
#             return "-#{AZ.toLowerCase()}"
#           ###*
#            * Get new option value
#            * @type {String}
#           ###
#           newVal = @element.attr "data-#{hyphenOpt}"

#           if newVal and newVal.trim()
#             @_setOption(opt,newVal)

#     _setOption: (key,val)->
#       if key is 'dir' and (val isnt 'rtl' or val isnt 'ltr')
#         return
#       @_super key, val
    
#     _setActive : ->
#       ###*
#        * check the link hash is refiring to any of the tabs and if is return this item
#        * @type {jQuery object}
#       ###
      
#       item = @links.filter "[href='"+location.hash+"']"
#       if item.length > 0
#         return item.first().parent()
#       ###*
#        * find the active tab and return the first one 
#        * @type {jQuery object}
#       ###
#       item = tabs.filter('.active')
#       if item.length > 0
#         return item.first()
#       ###*
#        * if it's nothing from the above then set the first tab as the active elemnt
#       ###
#       return @tabs.first()
    
#     ###*
#      * change the postion of the @indicator by some animation 
#      * @return {jQuery object}
#     ###
#     _updateIndicator : ->
#       ###*
#        * @active tab left offset relative to it parent
#        * @type {numper}
#       ###
#       actvPos = @active.position().left
#       cla = ['mv-right','mv-left']
      
#       if @active.css('float') is 'right'
#         cla.reverse()

#       @indicator.removeClass("#{cla[0]} #{cla[1]}").addClass(if @oldIndex < @currentIndex then cla[0] else cla[1]).css
#         left: actvPos
#         right: @element.width() - (actvPos + @active.outerWidth() )

#     ###*
#      * watch for window resizing
#      * @return {jQuery object}
#     ###
#     _setActivePanel: ->
#       panel = @panels.filter "##{@active.attr 'aria-controls'}"
      
#       @activePanel?.removeClass 'active' 
      
#       return panel.removeClass('on-right on-left').addClass 'active'

#     _updatePanel : ->
#       that = this
#       @tabs.not(@active).each ->
#         tab = $ this
#         panel = that.panels.filter "##{tab.attr 'aria-controls'}"
#         tabPos = that.tabs.index tab
        
#         classes =if that.options = 'rtl' then ['on-right','on-left'] else  ['on-left','on-right']
        
#         panel.removeClass("#{classes[0]} #{classes[1]}").addClass(if tabPos > that.currentIndex then classes[0] else classes[1])


#     _setActiveTab: (tab)->
#       if tab and (c = @tabs.filter(tab)).length
#       else if (c = @tabs.filter "[aria-controls='"+location.hash.replace('#','')+"']").length
#       else if (c = @tabs.filter '.active').length
#       else
#         c = @tabs.first()
#       return c.addClass 'active'
#     _updateActiveTab : (tab)->
#       @lastActive?.removeClass 'last-active'
#       @lastActive = @active?.removeClass('active').addClass 'last-active'
      
    
    
    
    


#     setActive : (tab) ->
#       @active = @_setActiveTab(tab)
      
#       @oldIndex = @currentIndex
#       @currentIndex = @tabs.index @active
      

#       @activePanel = @_setActivePanel()

#       @_updatePanel()
      
#       @_updateIndicator()

#     _onResize : ->
#       @_on window,
#         'resize' : ->
#           @_updateIndicator()
#     ###*
#      * watch for tabs selecting
#      * @return {jQuery object}
#     ###
#     _onClick : ->
#       @_on @element,
#         'click .tab' : (e) ->
#           ###*
#            * store the current clicked tab as ajquery object
#           ###
#           $target = $ e.currentTarget
#           ###*
#            * do nothing if this tab is already active or it is disabled
#           ###
#           if $target.hasClass('active') or $target.hasClass 'disabled'
#             return
#           @setActive($target)
         
#           ###*
#            * set new active tab
#           ###
#           # @active.removeClass 'active'
#           # @active = $target.addClass 'active'

      
    
    
        
    
    
    
$(document).ready ->
  $('.tabs').tabs()



do (jQuery = $) ->
  $.widget 'managIt.tabs',
    options :
      justify : false
      dir   : 'ltr'
      classes :
        activeTab : 'active'
        lastActiveTab : 'last-active'
        activePanel : 'active'
        lastActivePanel : 'last-active'
        panelPositioning : ['on-left','on-right']
        indicatorPositioning : ['mv-left','mv-right']

    _create : ->
      @tabs = @element.children '.tab'
      @panelsWrapper = @_setPanelsWrapper()
      @panels = @panelsWrapper?.children '.tab-panel'

      # if not (@panelsWrapper and @tabs and @panels and @panelsWrapper.length and (@tabs.length <= @panels.length))
      #   console.error 'unexpected error : please check this tabs html structure'
      #   return

      @_updateOptions()

      @element.wrap '<div class="tabs-wrapper"></div>' 
      @_updateTapsWrapper()

      @activeTab = @_setActiveTab()
      @lastActiveTab = @activeTab.addClass @options.classes.lastActiveTab
      
      @lastActiveTabIndex = null
      @activeTabIndex = @tabs.index @activeTab
      
      @indicator = @_setIndicator()

      @activePanel = @_setActivePanel()
      @lastActivePanel = @activePanel.addClass @options.classes.lastActivePanel

      @_onResize()

      @_onClick()

    _updateOptions : ->
      for opt of @options
        if @options.hasOwnProperty opt
          
          hyphenOpt = opt.replace /[A-Z]/g, (AZ) ->
            return "-#{AZ.toLowerCase()}"
          
          newVal = @element.attr "data-#{hyphenOpt}"

          if newVal and newVal.trim()
            @_setOption(opt,newVal)

    _setOption : (key,val)->
      @_super key, val

    _updateTapsWrapper : ->
      tabsWidth = 0
      @tabs.each ->
        tabsWidth += this.getBoundingClientRect().width
      @element.width tabsWidth
      
    _setActiveTab : (tab) ->
      if tab and (c = @tabs.filter(tab)).length
      else if (c = @tabs.filter "[aria-controls='"+location.hash.replace('#','')+"']").length
      else if (c = @tabs.filter '.active').length
      else
        c = @tabs
      @tabs.removeClass @options.classes.activeTab
      c.first().addClass @options.classes.activeTab
    _updateActiveTab : (tab)->
      @lastActiveTab?.removeClass @options.classes.lastActivePanel
      @lastActiveTab = @activeTab.addClass @options.classes.lastActivePanel
      @lastActiveTabIndex = @activeTabIndex
      @activeTab?.removeClass @options.classes.activeTab
      @activeTab = tab.addClass @options.classes.activeTab
      @activeTabIndex = @tabs.index @activeTab

    _setIndicator : ->
      indicator = $ "<div class='tabs-indicator'></div>"
      @_updateIndicator(indicator)
      @element.append indicator
      indicator

    _updateIndicator : (indicator = @indicator) ->
      actvPos = @activeTab.position().left
      cla = @options.classes.indicatorPositioning
      
      if @options.dir is 'rtl'
        cla.reverse()

      indicator.removeClass("#{cla[0]} #{cla[1]}").addClass(if @lastActiveTabIndex < @activeTabIndex then cla[1] else cla[0]).css
        left: actvPos
        right: @element.width() - (actvPos + @activeTab.outerWidth())
        
    _setPanelsWrapper : ->
      wrapper = null
      @tabs.each ->
        wrapper = $("##{this.getAttribute 'aria-controls'}").parent('.tabs-content')

        if wrapper.length
          return false
        else
          wrapper = null
      
      return wrapper
    _setActivePanel : (panel) ->
      panel = panel or @panels.filter "##{@activeTab.attr 'aria-controls'}"
        .addClass 'active'
        .removeClass @options.classes.panelPositioning[0],@options.classes.panelPositioning[1]
      panel
    _updateActivePanel : (panel) ->
      @lastActivePanel?.removeClass @options.classes.lastActivePanel
      @lastActivePanel = @activePanel.addClass @options.classes.lastActivePanel

      @activePanel?.removeClass @options.classes.activeTab
      @activePanel = @_setActivePanel(panel)

      @panelsWrapper.css
        height: @activePanel.height()
    _updatePanel : ->
      that = this    
      classes = if @options.dir is 'rtl' then @options.classes.panelPositioning.reverse() else  @options.classes.panelPositioning

      @tabs.not(@activeTab).each ->
        tab = $ this
        panel = that.panels.filter "##{tab.attr 'aria-controls'}"
        tabPos = that.tabs.index tab
        panel.removeClass("#{classes[0]} #{classes[1]}").addClass(if tabPos > that.activeTabIndex then classes[1] else classes[0])

    setActive : (tab) ->
      @_updateActiveTab(tab)
      @_updatePanel()
      @_updateActivePanel()
      @_updateIndicator()

    _onClick : ->
      @_on @element,
        'click .tab' : (e) ->
          
          $target = $ e.currentTarget
          
          if $target.hasClass('active') or $target.hasClass 'disabled'
            return

          @setActive($target)
        
          
    _onResize : ->
      @_on window,
        'resize' : ->
          console.log 'aaaaaa'
          @_updateIndicator()
    
    
    
    
    
    
    
    
    
    
    
    
    