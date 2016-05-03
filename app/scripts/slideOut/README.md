#jQuery slideout plugin
this plugin is fully under maintenance not even in a beta version

##Features
- Easy to use
- fully customizable

###dependencies
- [jQuery](https://jquery.com/)
- [jQuery Widget Factory](https://jqueryui.com/widget/] last version recomende)
- [VelocityJs](http://velocityjs.org/] +1.2.3)

##Browser Support
- Chrome (IOS, Android, desktop)
- Firefox (Android, desktop)
- Safari (IOS, Android, desktop)
- Opera (Android, desktop)
- IE 10+ (Android, desktop)

##API
###Options
- `menuWidth` set the slide out menu width <sup>`(240 !default)`</sup>
- `edge` where the menu will be on the `left` or the `right` <sup>`(left !default)`</sup>
- `inDuration` open animation duration in milliseconds <sup>`(200 !default)`</sup>
- `outDuration` close animation duration in milliseconds <sup>`(200 !default)`</sup>
- `stikOn` hard show the menu on screen after custom width <sup>`(1280 !default)`</sup>
- `closeOnSelect` hide the menu after select a valid link <sup>`(false !default)`</sup>
- `easing` the animation type <sup>`('easeOutQuad' !default)`</sup>

###Methodes

- `$el.slideOut('open')` : show the menu
- `$el.slideOut('close')` : close the menu
- `$el.slideOut('toggle')` : toggle the menu
- `$el.slideOut('isOpen')` : return true if it is open and false if not
