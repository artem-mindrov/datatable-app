$("#gifts").dataTable().fnAddData(<%= [ @gift.id, @gift.user.name, @gift.item.name ].to_json.html_safe %>)
