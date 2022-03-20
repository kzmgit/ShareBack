class TagsController < ApplicationController
  def index
    @tags = Tag.all.order(:url_word)
  end

  def show
    @tag = Tag.find_by(url_word: params[:word])
    # タグ名が同じで大文字と少文字違いの場合は統一する。(例：Rubyとruby)
    tags = Tag.where(url_word: params[:word])
    products = tags.map do |tag|
      tag.products
    end
    @products = products.flatten
  end
end
