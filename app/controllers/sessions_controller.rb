class SessionsController < ApplicationController
  def new
  end

  def create
    #①emailカラムでsessionネストメールアドレスを小文字化して見つける
    user = User.find_by(email:params[:session][:email].downcase)
    
# ②　①かつパスワード一致か判定
    if user && user.authenticate(params[:session][password])
      # session helperでuser をcookieies
      log_in (user)
      redirect_to (user)
    else
      flash.now[:danger] = '認証に失敗しました...'
      render :new
    end
  end

  def destory
    log_out
    flash.now[:success] = 'ログアウトしました'
    redirect_to root_url
  end

end
