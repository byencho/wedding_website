$(document).ready ->

  $('#nav-button').click (e) ->
    e.preventDefault()

    # Find dropdown navigation
    dropdownNav = $("#dropdown-nav")

    # If visible, make hidden (and vice versa)
    if dropdownNav.is(':visible')
      dropdownNav.get(0).style.display = "none"
      dropdownNav.addClass("inactive")
      dropdownNav.removeClass("active")
    else
      dropdownNav.get(0).style.display = "block"
      dropdownNav.removeClass("inactive")
      dropdownNav.addClass("active")
