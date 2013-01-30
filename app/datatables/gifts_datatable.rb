class GiftsDatatable
  delegate :params, :h, :link_to, :show_gift_path, :gift, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    Rails.logger.info "as_json options=#{options}"
    Rails.logger.info "as_json entries=#{gifts.total_entries}"

    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Gift.count,
      iTotalDisplayRecords: gifts.total_entries,
      aaData: data
    }
  end

private

# product: name, category, release date, price
# http://stackoverflow.com/questions/12743393/rails-add-action-button-delete-edit-etc-on-datatables-rails
  def data
    Rails.logger.info "data.... gifts=#{gifts.inspect}"
    gifts.map do |gift|
      [
        link_to(gift.id, gift),
        link_to(gift.user.name, gift),
        link_to(gift.item.name, gift),
      ]
    end
  end

  def gifts
    @gifts ||= fetch_gifts
  end

  # http://stackoverflow.com/questions/10507498/rails-datatables-server-side-processing-impossible-to-sort-find?rq=1
  def fetch_gifts
    gifts = Gift.order("#{sort_column} #{sort_direction}")
    gifts = gifts.page(page).per_page(per_page)
    if params[:sSearch].present?
      gifts = gifts.where("id like :search", search: "%#{params[:sSearch]}%")
    end
    gifts
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
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
