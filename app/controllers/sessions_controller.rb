class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      current_user
      redirect_to blogs_path
    else
      flash[:danger] = "ログインに失敗しました"
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path
  end
end
