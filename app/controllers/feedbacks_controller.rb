class FeedbacksController < ApplicationController
  def new
  end

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

  def edit
  end

  def updated
  end

  def destroy
  end

  private
    def feedback_params
      params.require(:feedback).permit(:good_point, :improvement_point, :other)
    end

end
