class CheckoutsController < ApplicationController
  before_action :set_user
  
  def create
    @checkout = @user.checkouts.new(check_out_time: Time.now)
  
    if @checkout.save
      render json: @checkout, status: :created
    else
      render json: @checkout.errors, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
  def checkout_params
    params.require(:checkout).permit(:check_out_time)
  end
end
  