class SessionsController < ApplicationController
  def new # ログイン機能
  end
  
  def create # ログイン認証機能　永続的セッションn機能
    user = User.find_by(email: params[:session][:email].downcase) # params[:session]でemailを取得。email情報をuserへ代入。
    if user && user.authenticate(params[:session][:password]) # emailを代入したuserとparams[:session]で取得したpasswordを認証。一致すればtrueを返す。
      log_in user # セッションヘルパーで定義した、ログインメソッド。このメソッドでログインが完了する。
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user # ログイン後に以前のページへリダイレクトする。フレンドリーフォワーディディング機能。
    else
     flash.now[:danger] = "認証に失敗しました。"
     render :new
    end
  end
  
  def destroy
  # ログイン中の場合のみログアウト処理を実行します。
    log_out if logged_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end
