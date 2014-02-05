$(document).ready ->
  #$('#rsvp-me').on('click', '#rsvp-me-cancel-button', removeAddMeForm)  
  #$('#rsvp-me').on('click', '#rsvp-me-submit-button', submitAddMeForm)
  $('.accounts-rsvp').on('click', '.form-button-cancel', removeForm)  
  $('.accounts-rsvp').on('click', '.form-button-submit', submitForm)
  $('.accounts-rsvp').on('click', '.edit-button', showEditForm) 
  $('.accounts-rsvp').on('click', '.edit-form-button-cancel', removeEditForm)  
  $('.accounts-rsvp').on('click', '.edit-form-button-submit', submitEditForm)
  $('.accounts-rsvp').on('click', '.edit-form-button-delete', submitEditFormDelete)

# Add a change listener to disable other "EDIT" buttons if one is currently open

removeForm = (e) ->
  e.preventDefault()

  # Get target element and parent (main form)
  button = e.target
  embeddedForm = button.parentNode

  # Get guest type
  formId = embeddedForm.id
  type = formId.replace "embedded-form-", ""

  # Hide button and remove form
  embeddedForm.remove()
  addButton = $("#rsvp-#{type}-add-button")
  addButton.show()

submitForm = (e) ->
  e.preventDefault()

  # TODO NOTE THAT THIS DOES NOT NECESSARILY DISABLE THE BUTTONS  
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
    type: form[0].method
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
        console.log(errorsList)
        for error in results.message
          errorsList.append("<li>#{error}</li>")

showEditForm = (e) ->
  e.preventDefault()

  # Check if this button is disabled...

  # Get target element and parent (main form)
  button = e.target
  savedGuest = button.parentNode

  # Remove listeners on all edit buttons
  #$('.accounts-rsvp').off('click', '.edit-button') 
  $(".edit-button").attr("disabled", true)

  # Hide current details view
  $("##{savedGuest.id}").hide()

  # Find appropriate edit form and show it
  guestId = savedGuest.id.replace "saved-guest-", ""
  $("#edit-form-#{guestId}").show()

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
  $("##{embeddedFormId}").hide()

  # Show the details again for that guest
  guestId = embeddedFormId.replace "edit-form-", ""
  $("#saved-guest-#{guestId}").show()

  # Add listeners back
  #$('.accounts-rsvp').on('click', '.edit-button', showEditForm) 
  $(".edit-button").removeAttr("disabled")


submitEditForm = (e) ->
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
    type: form[0].method
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
