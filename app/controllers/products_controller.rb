class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    if @product.save
      flash[:success] = "投稿しました！"
      redirect_to product_path(@product)
    else
      render :new
    end

  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = "変更を保存しました！"
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:success] = "削除しました！"
      redirect_to products_path
    else
      render :edit
    end
  end

  private

    def product_params
      params.require(:product).permit(:user_id, :title, :overview ,:body, :features, :technology, :image)
    end

    # beforeアクション
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:error] = "ログインしてください"
        redirect_to login_path
      end
    end

    # userがカレントユーザーであればtrueを返す
    def correct_user
      product = Product.find(params[:id])
      user = product.user
      unless current_user?(user)
        redirect_to root_path
      end
    end


end
