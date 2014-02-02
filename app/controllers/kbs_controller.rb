class KbsController < ApplicationController
  def index
     @faqs = Kb.all
  end
  
  def show
     @faq = Kb.find(params[:id])
  end
  
  def new
    @faq = Kb.new
    @subjects = Subject.all
  end
  
  def create
     @faq = Kb.new(params[:kb])
      if @faq.save
        flash[:notice] = 'A new user created successfully.'
        redirect_to @faq
      else
        flash[:error] = 'An error occurred please try again!'
        redirect_to kbs_path
      end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
end
