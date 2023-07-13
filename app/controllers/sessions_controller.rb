class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase) # params[:session]でemailを取得。email情報をuserへ代入。
    if user && user.authenticate(params[:session][:password]) # emailを代入したuserとparams[:session]で取得したpasswordを認証。一致すればtrueを返す。
      log_in user # セッションヘルパーで定義した、ログインメソッド。このメソッドでログインが完了する。
      remember user
      redirect_to user # ログイン後にユーザー詳細ページへリダイレクトする。
    else
     flash.now[:danger] = "認証に失敗しました。"
     render :new
    end
  end
  
  def destroy
    log_out # セッションヘルパーで定義した、ログアウトメソッド
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end
