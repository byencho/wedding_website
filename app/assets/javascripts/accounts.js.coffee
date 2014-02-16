$(document).ready ->
  $('.accounts-rsvp').on('click', '.add-button', showForm) 
  $('.accounts-rsvp').on('click', '.form-button-cancel', removeForm)  
  $('.accounts-rsvp').on('click', '.form-button-submit', submitForm)
  $('.accounts-rsvp').on('click', '.edit-button', showEditForm) 
  $('.accounts-rsvp').on('click', '.edit-form-button-cancel', removeEditForm)  
  $('.accounts-rsvp').on('click', '.edit-form-button-submit', submitEditForm)
  $('.accounts-rsvp').on('click', '.edit-form-button-delete', submitEditFormDelete)
  $('.custom-button').removeAttr("disabled")

showForm = (e) ->
  e.preventDefault()

  # Get target element and parent (main form)
  button = e.target
  savedGuest = button.parentNode

  # Remove listeners on all buttons
  $(".edit-button").attr("disabled", true)
  $(".add-button").attr("disabled", true)

  # Find appropriate for and show it (by sliding in)
  guestType = button.id.replace "rsvp-add-button-", ""
  $("#embedded-form-#{guestType}").slideDown();

  $("##{button.id}").fadeOut();

removeForm = (e) ->
  e.preventDefault()

  # Get target element and parent (main form)
  button = e.target
  embeddedForm = button.parentNode

  # Get guest type
  formId = embeddedForm.id
  type = formId.replace "embedded-form-", ""

  # Remove form and show buttons
  $("##{embeddedForm.id}").slideUp();
  $("#rsvp-add-button-#{type}").fadeIn();

  $(".edit-button").removeAttr("disabled")
  $(".add-button").removeAttr("disabled")

submitForm = (e) ->
  e.preventDefault()

  # Temporarily disable all custom buttons
  $(".form-button").attr("disabled", true)

  # Get target element and parent (main form)
  button = e.target
  embeddedForm = button.parentNode

  # Get guest type
  formId = embeddedForm.id
  type = formId.replace "embedded-form-", ""

  # Clear errors list
  errorsContainer = $("##{formId} .errors-container")
  errorsList = $("##{formId} .errors-list")
  errorsList.empty()

  # Get actual form
  form = $("##{formId} form")

  $.ajax
    url: form[0].action
    type: form[0].method
    dataType: 'html'
    data: form.serialize()
    error: (jqXHR, textStatus, errorThrown) ->
      $(".form-button").removeAttr("disabled")

      # Show errors list
      errorsContainer.show()

      # Append new errors to list
      errorsList.append("<li>Something terrible!</li>")

    success: (data, textStatus, jqXHR) ->  
      results = JSON.parse(data)
      if results.success
        location.reload();
      else
        $(".form-button").removeAttr("disabled")

        # Show errors list
        errorsContainer.show()

        # Append new errors to list
        for error in results.message
          errorsList.append("<li>#{error}</li>")

showEditForm = (e) ->
  e.preventDefault()

  # Get target element and parent (main form)
  button = e.target
  savedGuest = button.parentNode

  # Remove listeners on all edit buttons
  $(".edit-button").attr("disabled", true)
  $(".add-button").attr("disabled", true)

  # Find appropriate edit form and show it (by sliding in)
  guestId = savedGuest.id.replace "saved-guest-", ""
  $("#edit-form-#{guestId}").slideDown();

removeEditForm = (e) ->
  e.preventDefault()

  # Get target element and parent (main form)
  button = e.target
  embeddedForm = button.parentNode

  # Get guest type
  formId = embeddedForm.id
  type = formId.replace "embedded-form-", ""

  # Hide form
  embeddedFormId = embeddedForm.id
  $("##{embeddedFormId}").slideUp();

  # Show the details again for that guest
  guestId = embeddedFormId.replace "edit-form-", ""
  $("#saved-guest-#{guestId}").show()

  # Add listeners back
  $(".edit-button").removeAttr("disabled")
  $(".add-button").removeAttr("disabled")


submitEditForm = (e) ->
  e.preventDefault()

  # Temporarily disable all custom buttons
  $(".form-button").attr("disabled", true)

  # Get target element and parent (main form)
  button = e.target
  embeddedForm = button.parentNode

  # Get guest type
  formId = embeddedForm.id
  type = formId.replace "embedded-form-", ""

  # Clear errors list
  errorsContainer = $("##{formId} .errors-container")
  errorsList = $("##{formId} .errors-list")
  errorsList.empty()

  # Get actual form
  form = $("##{formId} form")

  $.ajax
    url: form[0].action
    type: form[0].method
    dataType: 'html'
    data: form.serialize()
    error: (jqXHR, textStatus, errorThrown) ->
      $(".form-button").removeAttr("disabled")

      # Show errors list
      errorsContainer.show()

      # Append new errors to list
      errorsList.append("<li>Something terrible!</li>")
    success: (data, textStatus, jqXHR) -> 
      results = JSON.parse(data)
      if results.success
        location.reload();
      else
        $(".form-button").removeAttr("disabled")

        # Show errors list
        errorsContainer.show()

        # Append new errors to list
        for error in results.message
          errorsList.append("<li>#{error}</li>")

submitEditFormDelete = (e) ->
  e.preventDefault()

  # Temporarily disable all custom buttons
  $(".custom-button").attr("disabled", true)

  # Get target element and parent (main form)
  button = e.target
  embeddedForm = button.parentNode

  # Get guest type
  formId = embeddedForm.id
  type = formId.replace "embedded-form-", ""

  # Clear errors list
  errorsContainer = $("##{formId} .errors-container")
  errorsList = $("##{formId} .errors-list")
  errorsList.empty()

  # Get actual form
  form = $("##{formId} form")

  $.ajax
    url: form[0].action
    type: "DELETE"
    dataType: 'html'
    data: form.serialize()
    error: (jqXHR, textStatus, errorThrown) ->
      $(".custom-button").removeAttr("disabled")

      # Show errors list
      errorsContainer.show()

      # Append new errors to list
      errorsList.append("<li>Something terrible!</li>")
    success: (data, textStatus, jqXHR) -> 
      results = JSON.parse(data)
      if results.success
        location.reload();
      else
        $(".custom-button").removeAttr("disabled")

        # Show errors list
        errorsContainer.show()

        # Append new errors to list
        for error in results.message
          errorsList.append("<li>#{error}</li>")
