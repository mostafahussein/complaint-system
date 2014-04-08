class ActivitiesController < ApplicationController
  def index
  	if params[:tab] == 'system_activities'
    	@activities = PublicActivity::Activity.order("created_at desc").page(params[:page]).per_page(15)
    else
    	render_404
    end
  end
end
