class TagsController < ApplicationController
  def index
    @tags = Tag.all.order(:name)
  end

  def show
    @tag = Tag.find_by(url_word: params[:word])
    @products = Tag.find_by(url_word: params[:word]).products
  end
end
