class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :exist_item?, only: [:show, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :seller?, only: [:edit, :update, :destroy]

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
    @item.update(item_params)
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :text, :category_id, :condition_id, :postage_id, :prefecture_id, :day_id,
                                 :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def exist_item?
    redirect_to action: :index unless Item.find_by(id: params[:id])
  end

  def seller?
    redirect_to action: :index unless @item.user_id == current_user.id
  end
end
