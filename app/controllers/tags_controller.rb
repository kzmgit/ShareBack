class TagsController < ApplicationController
  def index
  end

  def show
    @tag = Tag.find_by(url_word: params[:word])
    @products = Tag.find_by(url_word: params[:word]).products
  end
end
