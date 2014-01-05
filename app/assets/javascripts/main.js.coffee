$(document).ready ->

  $('#nav-button').click ->
    # Find dropdown navigation
    dropdownNav = $("#dropdown-nav")

    # If visible, make hidden (and vice versa)
    if dropdownNav.is(':visible')
      dropdownNav.get(0).style.display = "none"
    else
      dropdownNav.get(0).style.display = "block"
