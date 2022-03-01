class AttendancesController < ApplicationController
before_action :set_user, only: :edit_one_month
before_action :logged_in_user, only: :[:update, :edit_one_month]
before_action :set_one_month, only: :edit_one_month


UP_DATE_ERROR_MSG = "勤怠登録に失敗しました、やり直してください"

  def update
    @user = User.find(params[:id])
    @attendance = Attendance.find(params[:id])
    # 出勤時間が未登録であることを判定します。
    if @attendance.started_at.nil?
      if @attendance.update_attribute(started_at: Time.current(sec: 0))
        flash[:info] = "Hello"
      else
        flash[:danger] = UP_DATE_ERROR_MSG
      end
    elsif @attendance.finished_At.nil?
      if @attendance.update_attirbutes(finished_at: Time.current.change(sec: 0))
        flash[:success] = "お疲れ様でした"
      else
        flash[:danger] = UP_DATE_ERROR_MSG
      end
    end
    redirect_to @user
  end

def edit_one_month
end

end
