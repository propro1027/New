class SessionsController < ApplicationController
  def new
  end

  def create
    #①emailカラムでsessionネストメールアドレスを小文字化して見つける
    user = User.find_by(email: params[:session][:email].downcase)
    
    
# ②　①かつパスワード一致か判定
    if user && user.authenticate(params[:session][:password])
      # session helperでuser をcookieies
      log_in (user)
      params[:session][:remenber_me] == "1"? remenber(user) : forget(user)
      remenber (user)
      redirect_to (user)
    else
      flash.now[:danger] = '認証に失敗しました...'
      render :new
    end
  end

  def destory
    # ログイン中の場合のみログアウト処理を実行します。
    log_out if logged_in?
    flash.now[:success] = 'ログアウトしました'
    redirect_to root_url
  end

end
