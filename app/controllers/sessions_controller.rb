class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    # ユーザーが存在する && パスワード入力が正しい
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "ログインしました！"
      log_in(user)
      redirect_to root_path
    else
      flash.now[:danger] = 'メールとパスワードの組み合わせが無効です。'
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = "ログアウトしました！"
    redirect_to root_path
  end
end
