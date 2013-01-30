$ ->
  $("#gift_user_id").change ->
    $.ajax
      url: $(@).data("items-url")
      dataType: "json"
      data: { allowed_for: $(@).val() }

      success: (data, status, xhr) ->
        $("#gift_item_id").find("option").remove()

        $.each data, ->
          $("#gift_item_id").append( $("<option/>", value: @id, text: @name) )
