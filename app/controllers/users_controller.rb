class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:index, :show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def show
  end
  
  def create
    @user = User.new(user_params) # [user_params]内にはハッシュが格納されている。new.html.erbのフォーム内容（"user"=>{"name"=>"", "email"=>"", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}）
    if @user.save
      log_in @user #保存成功後、ログインします。
      flash[:success] = "新規登録に成功しました。"
      redirect_to @user # ここの@userはユーザー詳細ページへ遷移する。
    else
      render :new
    end
    
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation) # セキュリティー上、以下のカラムのみを許可。プライベートで情報が表に表示されない。
    end
    
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
  
end
