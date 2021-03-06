class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.order(:email)
  end

  def show 

  end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User has been created."
      redirect_to admin_users_path
    else 
      flash[:alert] = "User hasn't been created."
      render 'new'
    end
  end

  def edit 

  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    
    if @user.update(user_params)
      flash[:notice] = "User has been updated."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been updated."
      render 'edit'
    end
  end

  def destroy
    if @user == current_user 
      flash[:alert] = "Cannot delete yourself."
      redirect_to admin_users_path
    else
      @user.destroy
      flash[:notice] = "User has been deleted."
      redirect_to admin_users_path
    end
  end

private 
  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
