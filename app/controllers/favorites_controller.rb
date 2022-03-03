class FavoritesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    product = Product.find(params[:product_id])
    favorite = Favorite.new(user_id: current_user.id, product_id: product.id)
    favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    product = Product.find(params[:product_id])
    favorite = Favorite.find_by(user_id: current_user.id, product_id: product.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end

end