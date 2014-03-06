class KbsController < ApplicationController
  def index
    if params[:tab] == 'categories'
      @subjects = Subject.order("id asc")
    elsif params[:tab] == 'questions'
      @subject = Subject.find(params[:subject_id])
    else
      render_404
    end
  end
  
  def show
     @faq = Kb.find(params[:id])
  end
  
  def new
    @faq = Kb.new
    respond_to do |format|
      format.html # new.html.erb
      format.js # new.js.erb
      format.json { render json: @faq }
    end
  end
  
  def create
     @faq = Kb.new(params[:kb])
      if @faq.save
        flash[:notice] = 'A new question created successfully.'
        redirect_to kbs_path(tab: 'categories')
      else
        flash[:error] = 'An error occurred please try again!'
        redirect_to kbs_path(tab: 'categories')
      end
  end
  
   def edit
    @faq = Kb.find(params[:id])
    respond_to do |format|
      format.html # edit.html.erb
      format.js # edit.js.erb
      format.json { render json: @response }
    end
  end
  
  def update
    @faq = Kb.find(params[:id])
    if @faq.update_attributes(params[:user])
      flash[:notice] = 'Question updated'
      redirect_to :back
    else
      render 'edit'
    end
  end
  
  def destroy
    @faq = Kb.find(params[:id])
    @faq.destroy
    respond_to do |format|
        format.html
        format.js # destroy.js.erb
        format.json { head :no_content }
    end
  end
end
