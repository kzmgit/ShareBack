class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @products = Product.where(user_id: @user.id)
    # @userがいいねしたproductのidを配列でfavoritesに保存
    favorites = Favorite.where(user_id: @user.id).pluck(:product_id)
    @favorites_products = Product.find(favorites)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the ShareBack!"
      log_in(@user)
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィール情報を更新しました!"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

    def destroy
      @user = User.find(params[:id])
      if @user.destroy
        flash[:success] = "アカウントを削除しました"
        redirect_to root_path
      else
        render :edit
      end
    end


  private

    def user_params
      params.require(:user).permit(:name, :email, :introduction, :password, :password_confirmation, :image)
    end

    # @userがカレントユーザーであればtrueを返す
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        redirect_to root_path
      end
    end
end
