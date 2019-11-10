class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_url, status: :ok
    else
      flash.now[:alert] = 'Email or password is invalid'
      redirect_to root_url, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, status: :ok
  end

  def show
    current_user
    if @current_user.nil?
      head :no_content
    else
      render json: @current_user, status: :ok
    end
  end
end
