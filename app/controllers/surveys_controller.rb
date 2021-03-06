class SurveysController < ApplicationController
  def index
    @surveys = Survey.all
  end

  def show
    @survey = Survey.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.js # show.js.erb
      format.json { render json: @survey }
    end
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(params[:survey])
    if @survey.save
      redirect_to @survey, notice: "Successfully created survey."
    else
      render :new
    end
  end

  def edit
    @survey = Survey.find(params[:id])
  end

  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(params[:survey])
      redirect_to @survey, notice: "Successfully updated survey."
    else
      render :edit
    end
  end

  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    respond_to do |format|
        format.html
        format.js # destroy.js.erb
        format.json { head :no_content }
      end
  end
end
