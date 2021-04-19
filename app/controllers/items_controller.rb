class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :exists_item?, only: [:show, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :reject_edit, only: [:edit]
  before_action :reject_buyer, only: [:update, :destroy]

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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :text, :category_id, :condition_id, :postage_id, :prefecture_id, :day_id,
                                 :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def exists_item?
    redirect_to action: :index unless Item.find_by(id: params[:id])
  end

  def reject_edit
    redirect_to action: :index if Order.find_by(item_id: params[:id]) || @item.user_id != current_user.id
  end

  def reject_buyer
    redirect_to action: :index if @item.user_id != current_user.id
  end
end
