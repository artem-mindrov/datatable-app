class DatatablePresenter
  cattr_reader :columns
  @@columns ||= {}

  delegate :params, :h, :link_to, :show_gift_path, :gift, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    Rails.logger.info "as_json options=#{options}"
    Rails.logger.info "as_json entries=#{__collection.total_entries}"

    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: model.count,
      iTotalDisplayRecords: __collection.total_entries,
      aaData: __data
    }
  end

  def self.model
    self.name.gsub(/Datatable$/, "").singularize.constantize
  end

  def model
    self.class.model
  end

  def self.column(method, name, options = {}, &block)
    @@columns[method] = { name: name, options: options }

    define_method(method) do |*args|
      block[@view, *args]
    end
  end

  def self.column_methods
    @@columns.keys
  end

  def self.column_names
    @@columns.map { |c,data| data[:name] }
  end

  def self.options(column)
    @@columns[column][:options]
  end

  def row_data_for(item, options = {})
    self.class.column_methods.map { |m| send(m, item, options) }
  end

  private

  def __data
    __collection.map do |item|
      row_data_for(item)
    end
  end

  def __collection(*args, &block)
    @collection ||= fetch_collection(*args, &block)
  end

  def fetch_collection(*args, &block)
    filter_collection(*args, &block).order("#{sort_column} #{sort_direction}").page(__page).per_page(per_page)
  end

  def filter_collection(*args, &block)
    model
  end

  def __page
    params[:iDisplayStart].to_i / per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[id]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end