#// For fluid containers
#// http://datatables.net/ref#fnServerData
defaults =
  sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
  sPaginationType: "bootstrap"
  aaSorting: [[0,'desc']]
  aoColumns: [null, { "bSortable": false}, { "bSortable": false}]
  bProcessing: true
  bServerSide: true

  oLanguage:
    sSearch: "Search all columns"

$ ->
  $('.datatable').each ->
    el = $(@)
    opts = $.extend(defaults, el.data("table-options"))
    opts = $.extend(opts, sAjaxSource: el.data('source'))

    el.dataTable(opts)

  updateTables = ->
    $('.datatable').each ->
      $(@).dataTable().fnReloadAjax()

  setInterval(updateTables, 60 * 1000)

  $("tfoot input").keyup ->
    # Filter on the column (the index) of this element
    $(@).closest("table.datatable").dataTable().fnFilter( @value, $("tfoot input").index(@) )

  $("tfoot input").each (i) ->
    $(@).data("init-value", @value)

  $("tfoot input").focus ->
    $(@).removeClass("search_init").val("")

  $("tfoot input").blur (i) ->
    if @value == ""
      $(@).addClass("search_init").val( $(@).data("init-value") )
