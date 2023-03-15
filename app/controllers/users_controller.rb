class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  # before_action :find_user, except: %i[create index]
  skip_before_action :verify_authenticity_token, only: [:create, :new]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
          format.html { redirect_to alerts_path  }
          format.json {  render :json => @user }
      else
          format.html { render :new }
          format.json {  render :json => "Somthing Wrong" }
      end
    end
  end

  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find_by_username!(params[:_username])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation
    )
  end

end