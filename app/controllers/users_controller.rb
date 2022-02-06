class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
    else
      render :new
    end
  end
  
  # Web経由で外部のユーザーが知る必要は無いため、privateキーワードを用いて外部からは使用できないようにします。
  private
  	def user_params
  	  params.require(:user).permit(:name, :email, :password, :password_cofiramation) 
	 end
    
end
