class GiftsDatatable < DatatablePresenter
  column( :id, "ID", bSearchable: true ) do |ctxt, gift|
    ctxt.link_to(gift.id, gift)
  end

  column( :user_name, "User Name", bSearchable: true, bSortable: false ) do |ctxt, gift|
    ctxt.link_to(gift.user.name, gift)
  end

  column( :item_name, "Item Name", bSearchable: true, bSortable: false ) do |ctxt, gift|
    ctxt.link_to(gift.item.name, gift)
  end

  private

  def filter_collection
    gifts = Gift

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
end
