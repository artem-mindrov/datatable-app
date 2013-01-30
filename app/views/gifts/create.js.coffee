$("#gifts").dataTable().fnAddData(<%= GiftsDatatable.new(self).row_data_for(@gift).to_json.html_safe %>)
