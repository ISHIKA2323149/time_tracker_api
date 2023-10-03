class CheckInsController < ApplicationController
  before_action :set_user
  
  def create
    @check_in = @user.check_ins.new(check_in_time: Time.now)
  
    if @check_in.save
      render json: @check_in, status: :created
    else
      render json: @check_in.errors, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:user_id])
  end
end
  