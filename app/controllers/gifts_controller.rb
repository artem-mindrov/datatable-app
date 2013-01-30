class GiftsController < ApplicationController
  before_filter :set_required_variables, :only => [:index, :new]
  
  # GET /gifts
  # GET /gifts.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: GiftsDatatable.new(view_context) }
    end
  end

  # GET /gifts/1
  # GET /gifts/1.json
  def show
    @gift = Gift.find(params[:id])
  end

  # GET /gifts/new
  # GET /gifts/new.json
  def new
    @gift = Gift.new
  end

  # POST /gifts
  # POST /gifts.json
  def create
    @item = Item.find(params[:gift][:item_id])
    @gift = @item.gifts.new params[:gift]

    respond_to do |format|
      if @gift.save
        format.html { redirect_to gift_path(@gift), notice: 'Gift was successfully created.' }
        format.js
        format.json { render json: GiftsDatatable.new(view_context)}
      else
        format.html { set_required_variables; render action: "new" }
        format.js
        format.json { render json: @gift.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  def set_required_variables
    @users = User.all
    @items = Item.allowed_for(@users.first)
  end
end
