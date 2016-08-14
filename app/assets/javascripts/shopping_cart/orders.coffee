$(document).ready ->
  $(':checkbox').change ->
    if $('#use_billing_address_check').is(':checked')
      console.log('CHECKED')
      do $('#shipping_address').slideUp
    else
      console.log('UNCHECKED')
      do $('#shipping_address').slideDown
  $(':radio').click ->
    $('span.shipping').text(formated_shipping(this))
    $('span.total').text(formated_total(this))
  if $(':radio').is(':checked')
    $('span.shipping').text(formated_shipping($(':radio[checked="checked"]')))
    $('span.total').text(formated_total($(':radio[checked="checked"]')))


formated_total = (field) ->
  '$' + (parseFloat($(field).attr('data')) + parseFloat($('.sub-total').attr('data'))).toFixed(2)
formated_shipping = (field) ->
  '$' + parseFloat($(field).attr('data')).toFixed(2)
