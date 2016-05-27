class Drobdown
  NAME = "drobdown"
  DATA_KEY = "mi.#{NAME}"
  EVENT_KEY = ".#{DATA_KEY}"

  Events =
    show : "show#{EVENT_KEY}"
    hide : "hide#{EVENT_KEY}"

  Default =
    animatable : true
    hoverable : false
    alignment : 'auto'

  DefaultTypes =
    animatable : 'boolean'
    hoverable : 'boolean'
    alignment : 'string'
  
  constructor: (element, options) ->
    @config = _getConfig options
    @tglBtn = $ element
    @drobMenu = @tglBtn.attr "##{$ 'aria-controls'}"
    
    @drobMenu.data 'isShowen', no
  _getConfig = (config) ->
    config = $.extend {}, Default, config
    ManagIt.updateConfig config, @element[0]
    ManagIt.typeCheckConfig NAME, config, DefaultType
    config
  toggle : ->
    
    
  show : ->
    if @drobMenu.data(isShowen) is yes then false
    
    @tglBtn
    @tglBtn.after @drobMenu

    
    if @config.alignment is 'auto'
    winTop = window.scrollTop
    winBottom = top + window.innerHeight
    winLeft = window.scrollLeft
    winRight = left + ww

  _setAlignment = ->
    
  
  