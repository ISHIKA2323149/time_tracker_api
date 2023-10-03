class WorkTimeController < ApplicationController
    before_action :set_user
  
    def current_total_work_time
      current_time = Time.now
      check_ins_today = @user.check_ins.where("created_at >= ?", current_time.beginning_of_day)
     check_outs_today = @user.checkouts.where("created_at >= ?", current_time.beginning_of_day)

  
      total_work_time = calculate_total_work_time(check_ins_today, check_outs_today)
  
      formatted_total_work_time = format_total_work_time(total_work_time)
  
      render json: { current_work_time: formatted_total_work_time }
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def calculate_total_work_time(check_ins, check_outs)
      total_work_time = 0
  
      if check_ins.count == check_outs.count
        check_ins.count.times do |i|
          total_work_time += check_outs[i].created_at - check_ins[i].created_at
        end
      end
  
      return total_work_time
    end
  
    def format_total_work_time(total_work_time)
      hours = (total_work_time / 3600).to_i
      minutes = ((total_work_time % 3600) / 60).to_i
      seconds = (total_work_time % 60).to_i
  
      formatted_time = "#{hours} hours, #{minutes} minutes, #{seconds} seconds"
      return formatted_time
    end
  end
  