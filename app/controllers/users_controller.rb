class UsersController < ApplicationController
  def index
    @users = User.all
  end


  def show
    @user = User.find(params[:id])
    @student = @user.student
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'A new user created successfully.'
      redirect_to @user
    else
      flash[:error] = 'An error occurred please try again!'
      redirect_to users_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Profile updated'
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      flash[:error] = "Admin suicide warning: Can't delete yourself."
      redirect_to users_path
    else
      @user.destroy
      flash[:success] = "User deleted."
      redirect_to users_path
    end
  end
end
