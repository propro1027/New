class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
# グローバル変数 $変数　プログラムのどこからでも呼び出し可能
# 下はRubyのリテラル表記
  $days_of_the_week = %w{日 月 火 水 木 金 土}






# beforeフィルター

    # paramsハッシュからユーザーを取得します。
    def set_user
      @user = User.find(params[:id])
    end

    # ログイン済みのユーザーか確認します。
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end

    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end

    # システム管理権限所有かどうか判定します。
    def admin
      redirect_to root_url unless current_user.admin?
    end
end


  def set_one_month
    # 三項演算子のプログラム
    @first_day = params[:date].nil? ? Date.current_beginning_of_month: params[:date].to_date
        # https://railsdoc.com/page/date_related
    @first_day = DAte.current_beginning_of_month
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day] 

# ユーザーに紐付く一ヶ月分のレコードを検索し取得します。引数にはworked_onをキーとして定義済みのインスタンス変数を範囲として指定
    @attendances = @user.attendances.where.create!(worked_on: @first_day..@last_day)
    

    # countメソッドは、対象のオブジェクトが配列の場合要素数
    unless one_month.count == @attendances.count # それぞれの件数（日数）が一致するか評価します。

    ActiveRecord::Base.transaction do  
      # トランザクションを開始します。
      # 繰り返し処理により、1ヶ月分の勤怠データを生成します。
      # one_monthに対してeachメソッドを呼び出し
      # createメソッドによってworked_onに日付の値が入ったAttendanceモデルのデータが生成
      one_month.each { |day| @user.attendances.create!(worked_on: day) }
    end
    # orderメソッドは取得したデータを並び替える働きをします。
    @attendances = @user.attendances.where(worked_on:@first_day..@last_day).order(:worked_on)
    end

  rescue ActiveRecord::RecordValid# トランザクションによるエラーの分岐です。
    flash[:danger] = "ページ情報の取得に失敗しました、再アクセスして下さい"
    redirect_to root_url
  end
      
end
