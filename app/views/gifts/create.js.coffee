$("#gifts").dataTable().fnAddData(<%= datatable_row_for(@gift).to_json.html_safe %>)
