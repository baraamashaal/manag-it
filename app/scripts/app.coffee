class @app
  constructor: () ->
    # $('#sidenav-init-btn').slideOut()
  hasHREF: (el)->
    href = el.getAttribute 'href'
    if href && href[0] != '#' then true else false
  

@managIt = new app();
  
