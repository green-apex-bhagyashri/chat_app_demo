class UsersController < ApplicationController
  before_action :authorize_request, except: [:create, :index, :show]
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
    @users = User.all
    # render json: ActiveModelSerializers::Adapter::Json.new(UserSerializer.new(@users)), status: :ok
    render json: @users, each_serializer: UserSerializer, status: :ok
  end

  # GET /users/{username}
  def show
    # render json: ActiveModelSerializers::Adapter::Json.new(UserSerializer.new(@users)).serializable_hash, status: :ok
    render json: @user, serializer: UserSerializer, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors},
             status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.find_by_username!(params[:_username])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
       :name, :username, :email, :password, :password_confirmation
    )
  end
end