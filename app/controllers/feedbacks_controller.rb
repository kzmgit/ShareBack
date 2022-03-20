class FeedbacksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @product = Product.find(params[:product_id])
    @feedbacks = @product.feedbacks
    @product_feedback = Feedback.new(feedback_params)
    @product_feedback.user_id = current_user.id
    @product_feedback.product_id = @product.id
    unless @product_feedback.save
      render "error" # feedbacks/error.js.erb
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @feedbacks = @product.feedbacks
    Feedback.find(params[:id]).destroy
  end

  private
    def feedback_params
      params.require(:feedback).permit(:good_point, :improvement_point, :other)
    end

end
