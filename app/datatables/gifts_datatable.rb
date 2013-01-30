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

  def row_data_for(gift)
    [
      link_to(gift.id, gift),
      link_to(gift.user.name, gift),
      link_to(gift.item.name, gift),
    ]
  end

private

# product: name, category, release date, price
# http://stackoverflow.com/questions/12743393/rails-add-action-button-delete-edit-etc-on-datatables-rails
  def data
    Rails.logger.info "data.... gifts=#{gifts.inspect}"
    gifts.map do |gift|
      row_data_for(gift)
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
      q = "%#{params[:sSearch]}%"
      gifts = gifts.joins(:user).
          joins("join items i on gifts.item_id = i.id").
          where("gifts.id like ? or i.name like ? or users.name like ?", q, q, q)

      gifts = gifts.where("users.name like ?", "%#{params[:sSearch_1]}%") if params[:sSearch_1].present?
      gifts = gifts.where("i.name like ?", "%#{params[:sSearch_2]}%") if params[:sSearch_2].present?
    else
      if params[:sSearch_1].present?
        gifts = gifts.joins(:user).where("users.name like ?", "%#{params[:sSearch_1]}%")
      end

      if params[:sSearch_2].present?
        gifts = gifts.joins('join items i on gifts.item_id = i.id').where("i.name like ?", "%#{params[:sSearch_2]}%")
      end
    end

    if params[:sSearch_0].present?
      gifts = gifts.where("gifts.id like :search", search: "%#{params[:sSearch_0]}%")
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
