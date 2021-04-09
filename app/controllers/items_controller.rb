class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :exist_item?, only: [:show, :edit, :update]
  before_action :is_seller?, only: [:edit, :update]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      redirect_to item_path
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :text, :category_id, :condition_id, :postage_id, :prefecture_id, :day_id,
                                 :price).merge(user_id: current_user.id)
  end

  def exist_item?
    unless Item.find_by(id: params[:id])
      redirect_to action: :index
    end
  end

  def is_seller?
    item = Item.find(params[:id])
    unless user_signed_in? && item.user_id == current_user.id
      redirect_to action: :index
    end
  end
end
