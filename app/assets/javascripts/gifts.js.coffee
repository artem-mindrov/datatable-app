#// For fluid containers
#// http://datatables.net/ref#fnServerData
jQuery -> 
  $('#gifts').dataTable 
     sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
     sPaginationType: "bootstrap"
     aaSorting: [[0,'desc']]
     aoColumns: [null, { "bSortable": false}, { "bSortable": false}]
     bProcessing: true
     bServerSide: true
     sAjaxSource: $('#gifts').data('source')

  updateTable = ->
    $("#gifts").dataTable().fnReloadAjax()

  setInterval(updateTable, 60 * 1000)