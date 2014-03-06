class UsersController < ApplicationController
  def index
    if params[:tab] == 'all'
      @users = User.order(:id)
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
    respond_to do |format|
        format.html # show.html.erb
        format.js # show.js.erb
        format.json { render json: @user }
      end
  end


  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.js # new.js.erb
      format.json { render json: @user }
    end
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
  respond_to do |format|
      format.html # edit.html.erb
      format.js # edit.js.erb
      format.json { render json: @user }
    end
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
    @users = User.order(:id)
    if @user == current_user
      flash[:error] = "Admin suicide warning: Can't delete yourself."
      redirect_to :back
    else
      @user.destroy
      respond_to do |format|
        format.html
        format.js # destroy.js.erb
        format.json { head :no_content }
      end
    end
  end
end
