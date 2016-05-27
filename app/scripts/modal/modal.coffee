# $.widget 'managIt.modal',
#   options :
#     dismissible : true
#     classes :
#       overlay : 'overlay modal-overlay'
  
  

#   _create : ->
    
#     @modal = $ "##{@element.attr 'aria-control'}"

#     @overlay = $ '<div>',
#       class : @options.classes.overlay
#       id : @modal.attr 'id'
    
#     if 
#     @_on @modal,
#       'click' : (e) ->
#         $target = $ e.target
        
#         if @options.dismissible is true and e.target.hasAttribute 'modal-close'
#           do @close

#   _updateOptions : ->
#     for opt of @options
#       if @options.hasOwnProperty opt
        
#         hyphenOpt = opt.replace /[A-Z]/g, (AZ) ->
#           return "-#{AZ.toLowerCase()}"
        
#         newVal = @element.attr "data-#{hyphenOpt}"

#         if newVal and newVal.trim()
#           @_setOption(opt,newVal)

#   _setOption : (key,val)->
#     @_super key, val

#   @hide : ->
      

#   @show : ->
         

class Modal
  NAME = 'modal'
  VERSION = '0.1Beta'
  DATA_KEY = "mi.#{NAME}"
  EVENT_KEY = ".#{DATA_KEY}"

  Events =
    show : "show#{EVENT_KEY}"
    hide : "hide#{EVENT_KEY}"
  
  Default =
    show : true
    focus : true
    dismissible : true

  DefaultType =
    show : 'boolean'
    focus : 'boolean'
    dismissible : 'boolean'

  constructor: (element, options)->
    @modal = element
  _getConfig = (config) ->
    config = $.extend {}, Default, config
    ManagIt.typeCheckConfig NAME, config, DefaultType
    config

  toggle : ->
    
  
  