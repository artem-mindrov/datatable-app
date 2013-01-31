module DatatablesHelper
  def datatable_row_for(what)
    presenter_for(what).new(self).row_data_for(item)
  end

  def datatable_headers_for(what)
    presenter_for(what).column_names
  end

  def datatable_for(what, options = {})
    p = presenter_for(what)
    options[:aoColumns] = p.columns.map { |col,data| data[:options] }
    render "datatables/table", model: p.model.model_name.underscore.downcase, options: options
  end

  def presenter_for(what)
    what = if what.is_a?(Array)
      what.first.class.name
    elsif what.is_a?(Symbol)
      what.to_s.classify
    elsif what.is_a?(String)
      what.classify
    else
      what.class.name
    end.pluralize

    "#{what}Datatable".constantize
  end
end