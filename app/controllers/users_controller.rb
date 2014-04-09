class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page], per_page: 4)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Micro-Posts!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end

  end


  def destroy
<<<<<<< HEAD
    #User.find(params[:id]).destroy
    @user = User.find(params[:id])
    #flash[:success] = "User deleted."
    if current_user.admin? && !current_user?(@user)
      @user.destroy
      flash[:success] = "User deleted."
    else
      flash[:danger] = "You can't delete yourself."

    end
=======
    User.find(params[:id]).destroy
    #@user = User.find(params[:id])
    flash[:success] = "User deleted."
    #if current_user.admin? && !current_user?(@user)
    #  @user.destroy
    #  flash[:success] = "User deleted."
    #else
    #  flash[:danger] = "You can't delete yourself."
    #
    #end
>>>>>>> update-users
    redirect_to users_url


  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def signed_in_user
    unless signed_in?
      store_location
      flash[:warning] = "Please sign in."
      redirect_to signin_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
    #unless current_user?(@user)
    #  flash[:warning] = "#{current_user.name}, You are not allowed to edit the #{@user.name} Profile"
    #  redirect_to(root_url)
    #end
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end


end
