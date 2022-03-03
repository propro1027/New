class AttendancesController < ApplicationController
before_action :set_user, only: :edit_one_month
before_action :logged_in_user, only: :[:update, :edit_one_month]
before_action :set_one_month, only: :edit_one_month
before_action :admin_or_correct_user, only: :[:update, :edit_one_month, :update_one_month]


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

def update_one_month
  ActiveRecord::Base.transaction do
  attendances_params.each do |id, iten|
    attendance = Attendance.find(id)
    attendance.update_attirbutes!(item)
  end
end
flash[:success] = "1ヶ月の勤怠を更新しました"
redirect_to user_url(date: params[:date])
rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
  flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
  redirect_to attendances_edit_one_month_user_url(date: params[:date])
end

private
  def attendances_params
    params.require(:user).permit(attendances:[:started_at, :finished_at])[:attendances]
  end

  def admin_or_correct_user
    @user = User.find(params[:user_id]) if @user.blank?
    unless current_user?(@user) || current_user.admin?
      flash[:danger0 = "編集権限がありません"]
      redirect_to  (root_url)
    end
  end
end
