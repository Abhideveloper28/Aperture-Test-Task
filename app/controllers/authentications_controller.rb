class AuthenticationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def new
  @user = User.new
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      session[:token] = token
      time = Time.now + 24.hours.to_i
        respond_to do |format|
          if @user.save
              format.html { redirect_to alerts_path  }
              format.json {  render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     user: @user }}
          end
        end
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def destroy    
    session[:token] = nil         
    respond_to do |format|
      format.html { render :new }
      format.json {  render :json => "Delete" }
    end 
  end 

  private

  def login_params
    params.permit(:email, :password)
  end
end
