class ResponsesController < ApplicationController
  def index
     @responses = Response.all
  end
  
  def show
     @response = Response.find(params[:id])
  end
  
  def new
    @response = Response.new
    respond_to do |format|
      format.html # new.html.erb
      format.js # new.js.erb
      format.json { render json: @response }
    end
  end
  
  def create
     @response = Response.new(params[:response])
      if @response.save
        flash[:notice] = 'A new response created successfully.'
        redirect_to responses_path
      else
        flash[:error] = 'An error occurred please try again!'
        redirect_to responses_path
      end
  end
  
  def edit
    @response = Response.find(params[:id])
    respond_to do |format|
      format.html # edit.html.erb
      format.js # edit.js.erb
      format.json { render json: @response }
    end
  end
  
  def update
    @response = Response.find(params[:id])
    if @response.update_attributes(params[:user])
      flash[:notice] = 'Response updated'
      redirect_to :back
    else
      render 'edit'
    end
  end
  
  def destroy
    @response = Response.find(params[:id])
    @response.destroy
    respond_to do |format|
        format.html
        format.js # destroy.js.erb
        format.json { head :no_content }
    end
  end
end
