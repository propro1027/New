class AttendancesController < ApplicationController
  def update
    @user = User.find(params[:id])
    @attendance = Attendance.find(params[:id])
    # 出勤時間が未登録であることを判定します。
    if @attendance.started_at.nil?
      if @attendance.update_attribute(started_at: Time.current(sec: 0))
        flash[:info] = "Hello"
      else
        flash[:danger] = "登録に失敗しました"
      end
    end
    redirect_to @user
  end
end
