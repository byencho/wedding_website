# Modified from Parallax Scrolling Tutorial (Author: Mohiuddin Parekh)
$(document).ready ->
  $(window).scroll(parallaxScroll)

parallaxScroll = ->
  thisWindow = $(this)
  $('div[data-type="background"]').each (index, object) ->
    bgObject = $(object)

    #Scroll the background at var speed
    #the yPos is a negative value because we're scrolling it UP!                
    yPos = -(thisWindow.scrollTop() / bgObject.data('speed'))
    
    #Put together our final background position
    coords = '50% '+ yPos + 'px';

    #Move the background
    bgObject.css({ backgroundPosition: coords })

  # Temporary, for comparing with old version
  $('section[data-type="background"]').each (index, object) ->
    bgObject = $(object)

    #Scroll the background at var speed
    #the yPos is a negative value because we're scrolling it UP!                
    yPos = -(thisWindow.scrollTop() / bgObject.data('speed'))
    
    #Put together our final background position
    coords = '50% '+ yPos + 'px';

    #Move the background
    bgObject.css({ backgroundPosition: coords })

#
# Create HTML5 elements for IE's sake
#
document.createElement("article");
document.createElement("section");