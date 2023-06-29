class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params) # [user_params]内にはハッシュが格納されている。new.html.erbのフォーム内容（"user"=>{"name"=>"", "email"=>"", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}）
    if @user.save
      flash[:success] = "新規登録に成功しました。"
      redirect_to @user # ここの@userはユーザー詳細ページへ遷移する。
    else
      render :new
    end
    
  end
  
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation) # セキュリティー上、以下のカラムのみを許可。プライベートで情報が表に表示されない。
    end
  
end
