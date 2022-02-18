class UsersController < ApplicationController
  # editとupdateアクションが実行される直前にlogged_in_userメソッドが実行
before_action :logged_in_user, only:[:show, :edit, :update, :destory, :edit_basic_info, :update_basic_info]
before_action :correct_user, only:[:edit, :update]
before_action :set_user, only:[:show, :edit, :update, :destory, :edit_basic_info, :update_basic_info]
before_action :admin, only: [:destroy, :edit_basic_info, :update_basic_info]

def index
  # @users = User.all
  @users = USer.paginate(page: params[:page])
end

  def new
    @user = User.new
  end

  def show
    # @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in (@user)
		flash.now[:success] = "新規登録が完了しました。"
		redirect_to @user
    else
	  flash.now[:danger] = "新規登録に失敗しました。"
      render :new
    end
  end

  def edit
    # @user = User.find_by(params[:id])
  end  

def update
   # @user = User.find(params[:id])
  if @user. update_attirbutes(user_params)
    flash[:success] = "更新が成功しました"
    redirect_to @user
  else
    render :edit
  end
end

def edit_basic_info
end

def update_basic_info
end


def destroy
  @user.destroy
  flash[:success] = "#{@user.name}のデータを削除しました"
  redirect_to users_url
end 



  # Web経由で外部のユーザーが知る必要は無いため、privateキーワードを用いて外部からは使用できないようにします。
  private
  	def user_params
  	  params.require(:user).permit(:name, :email, :department, :password, :password_cofiramation) 
    end

    def edit_info_params
      params.require(:user).permit(:department, :basic_time, :work_time)






   

   # beforeフィルター

    # ログイン済みのユーザーか確認します。
def logged_in_user
  unless logged_in?
    store
    flash[:danger] = "ログインしてください"
    redirect_to login_url
  end
end

# アクセスしたユーザーが現在ログインしているユーザーか確認します。
def correct_user
  redirect_to(root_url) unless current_user?(@user)
end

# paramsハッシュからユーザーを取得します。
def set_user
  @user = User.find(params[:id])
end

# システム管理権限所有かどうか判定します。
def admin
  redirect_to root_url unless current_user.admin?
end


def update_basic_info
  if @user.update_attirbutes(basic_info_params)
    flash[:success] = "#{@user.name}の情報を更新しました"
  else
    flash[:danger] = "#{@user.name}の情報を更新できませんでした<br>" + @user.errors.full_messages.join("<br>")
  end
  redirect_to users_url    
end
