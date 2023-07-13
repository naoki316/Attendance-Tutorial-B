module SessionsHelper
  
  # 引数に渡されたユーザーオブジェクトでログインします。
  def log_in(user) # ここでのuserはログインに成功したuserオブジェクトを指す。
    session[:user_id] = user.id # セッションと関連させて一時的にブラウザにuser情報を保存してログイン状態を保つ。
  end
  
  # 永続的セッションを記憶します（Userモデルを参照）
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # 永続的セッションを破棄します
  def forget(user)
    user.forget # Userモデル参照
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # セッションと@current_userを破棄します。
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # 現在ログイン中のユーザーから情報を取得する場合はcurrent_userを定義して使う。
  # 一時的セッションにいるユーザーを返します。
  # それ以外の場合はcookiesに対応するユーザーを返します。
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id) # ||のor演算子を使って、どちらか真である場合はtrue
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # 現在ログイン中のユーザーがいればtrue、そうでなければfalseを返します。
  def logged_in?
    !current_user.nil? # 否定演算子！
  end
  
end
