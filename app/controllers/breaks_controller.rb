class BreaksController < ApplicationController
  before_action :set_user
  before_action :set_break, only: [:show, :update, :destroy]
  
  def index
    @breaks = @user.breaks
    render json: @breaks
  end
  
  def show
    render json: @break
  end
  
  def create
    @break = @user.breaks.new(break_params)
  
    if @break.save
      render json: @break, status: :created
    else
      render json: @break.errors, status: :unprocessable_entity
    end
  end
   
  def update
    if @break.update(break_params)
      render json: @break
    else
      render json: @break.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @break.destroy
    head :no_content
  end
  
  private
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
  def set_break
    @break = @user.breaks.find(params[:id])
  end
  
  def break_params
    params.require(:break).permit(:break_in_time, :break_out_time)
  end
end
  