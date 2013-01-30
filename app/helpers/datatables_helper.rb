module DatatablesHelper
  def datatable_row_for(what)
    presenter_for(what).new(self).row_data_for(item)
  end

  def datatable_headers_for(what)
    presenter_for(what).column_names
  end

  def presenter_for(what)
    what = if what.is_a?(Array)
      what.first.class.name
    elsif what.is_a?(Symbol)
      what.to_s.classify.pluralize
    else
      what.class.name.pluralize
    end.pluralize

    "#{what}Datatable".constantize
  end
end