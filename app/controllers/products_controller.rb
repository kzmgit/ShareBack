class ProductsController < ApplicationController
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
  end

  private

    def product_params
      params.require(:product).permit(:user_id, :title, :body)
    end
end
