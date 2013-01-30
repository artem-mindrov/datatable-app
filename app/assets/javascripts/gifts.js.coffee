#// For fluid containers
#// http://datatables.net/ref#fnServerData
jQuery -> 
  oTable = $('#gifts').dataTable
     sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
     sPaginationType: "bootstrap"
     aaSorting: [[0,'desc']]
     aoColumns: [null, { "bSortable": false}, { "bSortable": false}]
     bProcessing: true
     bServerSide: true
     sAjaxSource: $('#gifts').data('source')
     oLanguage:
      sSearch: "Search all columns"

  updateTable = ->
    oTable.fnReloadAjax()

  setInterval(updateTable, 60 * 1000)

  $("tfoot input").keyup ->
    # Filter on the column (the index) of this element
    oTable.fnFilter( @value, $("tfoot input").index(@) )

  asInitVals = []

  $("tfoot input").each (i) ->
    asInitVals[i] = @value

  $("tfoot input").focus ->
    if @className == "search_init"
      @className = ""
      @value = ""

  $("tfoot input").blur (i) ->
    if @value == ""
      @className = "search_init"
      @value = asInitVals[$("tfoot input").index(@)]