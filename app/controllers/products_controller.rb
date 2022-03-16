class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @product_feedback = Feedback.new
    @feedbacks = @product.feedbacks
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    tag_list = params[:product][:tag_names].delete(' ').delete('　').split(',')
    if @product.max_tags(tag_list.count) && @product.save
      flash[:success] = "投稿しました！"
      @product.save_tags(tag_list)
      redirect_to product_path(@product)
    else
      @tag_list = tag_list.join(', ')
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    @tag_list = @product.tags.pluck(:name).join(', ')
  end

  def update
    @product = Product.find(params[:id])
    tag_list = params[:product][:tag_names].delete(' ').delete('　').split(',')
    if @product.update(product_params) && @product.max_tags(tag_list.count)
      flash[:success] = "変更を保存しました！"
      @product.save_tags(tag_list)
      redirect_to product_path(@product)
    else
      @tag_list = tag_list.join(', ')
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
      params.require(:product).permit(:user_id, :title, :url, :overview, :background, :usage, :ingenuity, :other, :features, :technology, :image)
    end

    # beforeアクション
    # userがカレントユーザーであればtrueを返す
    def correct_user
      product = Product.find(params[:id])
      user = product.user
      unless current_user?(user)
        redirect_to root_path
      end
    end

end
