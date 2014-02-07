class UsersController < ApplicationController
  def index
    if params[:tab] == 'all'
      @users = User.all
    elsif params[:tab] == 'active'
      @users = User.where(active: true)
    elsif params[:tab] == 'inactive'
      @users = User.where(active: false)
    else
      render_404
    end
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
     #UserMailer.email_confirmation(@user).deliver
      flash[:notice] = 'A new user created successfully.'
      redirect_to @user
    else
      flash[:error] = 'An error occurred please try again!'
      redirect_to :back
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Profile updated'
      redirect_to :back
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      flash[:error] = "Admin suicide warning: Can't delete yourself."
      redirect_to :back
    else
      @user.destroy
      flash[:success] = "User deleted."
      redirect_to :back
    end
  end
end
