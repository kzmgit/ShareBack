class FeedbacksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @product = Product.find(params[:product_id])
    @product_feedback = Feedback.new(feedback_params)
    @product_feedback.user_id = current_user.id
    @product_feedback.product_id = @product.id
    if @product_feedback.save
      redirect_to product_path(@product)
    else
      @feedbacks = @product.feedbacks
      render "products/show"
    end
  end

  def destroy
    Feedback.find(params[:id]).destroy
    redirect_to product_path(params[:product_id])
  end

  private
    def feedback_params
      params.require(:feedback).permit(:good_point, :improvement_point, :other)
    end

end
