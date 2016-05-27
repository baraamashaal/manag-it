



do ($ = jQuery) ->


	class Snackbar


		_snackbarQueue = []

		_snackbarShowen = false
		
		_isPanning = false
		
		_defOpts =
			duration : 3000
			dismissible : true
			classes : 
				snackbar : 'snackbar'
				snackbarText : 'snackbar-text'
				panning : 'panning'
				notDismissible : 'not-dismissible'
				hover : 'hovered'
				action : 'action-btn'
		constructor: (opts, done, actionHandler) ->
			@options = _updateOpts.call @, opts
			if _isValid @options, done, actionHandler then _snackbarQueue.push @options

			_show.call do _snackbarQueue.shift if not _snackbarShowen and _snackbarQueue.length > 0


		_updateOpts = (newOpts)->
			defOpts = $.extend {}, _defOpts

			if typeof newOpts is 'object'
				return $.extend defOpts, newOpts
			
			else if typeof newOpts is 'string'
				defOpts.message = newOpts
				
				return defOpts
			
		_isValid = (opts, done, actionHandler)->

			if not typeof opts.message is 'string' or not typeof opts.duration is 'number' or not typeof opts.actionText is 'string'
				return false

			if typeof done is 'function'
				opts.done = done

			if typeof actionHandler is 'function'
				opts.actionHandler = actionHandler

			return true

		_show = ->
			_snackbarShowen = true

			snackbar = _create.call @

			# snackbar $snackbar

			document.body.appendChild snackbar
					
					
			setTimeout (() ->
				snackbar.style.bottom = 0
			),20
					
			_hide.call @, snackbar

		_create = ->
			newsnackbar = document.createElement 'div'
			newsnackbar.classList.add @classes.snackbar
			
			snackbarText = document.createElement 'span'
			snackbarText.classList.add @classes.snackbarText
			snackbarText.textContent = @message
			
			newsnackbar.appendChild snackbarText
			
			if @actionText
				data = this
				snackbarAction = document.createElement 'span'
				snackbarAction.classList.add @classes.action
				snackbarAction.textContent = @actionText
				snackbarAction.addEventListener 'click', ->
					data.actionHandler?.call newsnackbar
					_remove.call data, newsnackbar
				
				newsnackbar.appendChild snackbarAction


			if @dismissible
				_dismissible.call @, newsnackbar
			else
				newsnackbar.classList.add @classes.notDismissible
				
				

			return newsnackbar


		_dismissible = (el)->
			data = this

			hammer = new Hammer el,
				prevent_default: false

			hammer.get 'pan'
				.set
					direction: Hammer.DIRECTION_VERTICAL
			
			el.addEventListener 'touchstart', (e) ->
				document.body.style.overflow = 'hidden'
			

			hammer.on 'pandown panup', (e) ->
				if e.deltaY < 0 then return
				
				if not _isPanning
					_isPanning = true
					el.classList.add data.classes.panning

				el.style.bottom = "#{e.deltaY * -1}px"
			
			hammer.on 'panend', (e)->
				if _isPanning
					_isPanning = false
					el.classList.remove data.classes.panning

				if e.deltaY <= 0 then return

				h = el.getBoundingClientRect().height
				
				if Math.abs(e.deltaY) > (h / 3)
					
					if e.deltaY < h

						el.style.bottom = "#{h * -1}px"

						setTimeout (() ->

							_remove.call data, el, false
						
						),200

					else

						_hide @, el

				else
					el.style.bottom = 0

			el.addEventListener 'touchend', (e) ->
				document.body.style.overflow = ''

		_hide = (el)->
			data = this

			timeLeft = @duration

			@counter = setInterval (->

				if not _isPanning
					timeLeft -= 20

				if timeLeft <= 0
					_remove.call data, el	

			),20
		
		_remove = (el, animate = true)->
			remove = =>
				_snackbarShowen = false
				do el.remove
				_show.call do _snackbarQueue.shift if _snackbarQueue.length > 0
			
			if animate
				console.log el
				el.style.bottom = '-48px'
				
				setTimeout (() ->
						do remove
				),200
			else
				do remove

			window.clearInterval(@counter);
		
	$.snackbar = (p) ->
		new Snackbar(p)

	new Snackbar 
		message : 'hello'
		actionText : 'undo'
		duration : 100000

	new Snackbar 
		message : 'hello2'
		actionText : 'settings'
		duration : 100000

	new Snackbar 
		message : 'hello3'
		actionText : 'confirm'
		duration : 100000

	new Snackbar 
		message : 'hello4'
		actionText : 'okay!'
		duration : 100000

	new Snackbar 
		message : 'hello5'
		actionText : 'yes'
		duration : 100000

	new Snackbar 
		message : 'hello6'
		actionText : 'toz'
		duration : 100000
	
