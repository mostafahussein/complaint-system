class ResponsesController < ApplicationController
  def index
     @responses = Response.all
  end
  
  def show
     @response = Response.find(params[:id])
  end
  
  def new
    @response = Response.new
  end
  
  def create
     @response = Response.new(params[:response])
      if @response.save
        flash[:notice] = 'A new response created successfully.'
        redirect_to @response
      else
        flash[:error] = 'An error occurred please try again!'
        redirect_to responses_path
      end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
end
