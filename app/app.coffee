class App
  constructor: (arguments) ->
    
  isNode : (obj) ->
    (obj[0] || obj).nodeType
  
  ###*
   * get the value of an ob
   * @param  {Any}        work on object 
   * @return {String}     typeof obj
   * @referance https://javascriptweblog.wordpress.com/2011/08/08/fixing-the-javascript-typeof-operator/
  ###
  toType : (obj) ->
    do ({}).toString.call(obj).match(/\s([a-zA-Z]+)/)[1].toLowerCase
  
  getType : (obj) ->
    if @isNode(obj) then return 'nodeElement' else return toType obj

  typeCheckConfig = (componentName, config, configTypes) ->
    for prop in configTypes
      if configTypes.hasOwnProperty prop
        expectedType = configTypes[prop]
        val = config[prop]
        valType = getType val

        if not new RegExp(expectedType).test(valType)
          throw new Error "#{componentName.toUpperCase()}: Option #{prop} provided type #{valType} but expected type #{expectedType}"
        
ManagIt = new App()