module SessionsHelper
  
  # ユーザーIDを一時的セッションの中に安全に記憶
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログインしているユーザーオブジェクトの各値を取れるようにすること
  # 現在ログイン中のユーザーがいる場合オブジェクトを返します。
  def current_user
  # if session[:user_id]
    # findだとnil発生ありうるからfind_by
        # A                  B      or               C     
    # @current_user = @current_user || User.find_by(id: session[:user_id])
    # ↑と同義
    # if session[:user_id]
    #   if @current_user.nil?
    #     @current_user = User.find_by(id: session[:user_id])
    #   else
    #     @current_user
    #   end
    # end
      # 一時的セッションにいるユーザーを返します。
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
        # それ以外の場合はcookiesに対応するユーザーを返します。
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remenber_token])
        log_in (user)
        @current_user = user
      end
    end
   end

# 現在ログイン中のユーザーがいればtrue、そうでなければfalseを返します。
  def logged_in?
  # current_userは空ではない？　つまり入れ歯true
  !current_user.nil?
  # unless logged_in?
  #   store
  #   flash[:danger] = "ログインしてください"
  #   redirect_to login_url
  #  end
  # end


    # 渡されたユーザーがログイン済みのユーザーであればtrueを返します。
 def current_user?(user)
  user == current_user
  end


 def log_out
  forget(current_user)
  session.delete(:user_id)
  @current_user= nil
 end

 def remenber(user)
  user.remenber
  # id get3
  cookies.permanent.signed[:user_id] = user.id
  # token get
  cookies.permanent[:remenber_token] = user.remenber_token
  
 end

  # 記憶しているURL(またはデフォルトURL)にリダイレクトします。
 def redirect_back_or(default_url)
  redirect_to (session[:fowarding_url]|| :default_url)
  session.delete(:fowarding_url)
 end

  # アクセスしようとしたURLを記憶します。
  def store
  session[:fowarding_url] = request.original_url if request.get?
  end

end
end