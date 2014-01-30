class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  protect_from_forgery
  before_filter :find_priority

  def find_priority
    @priorities = Priority.all
  end

  def render_404
    render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
  end

  private

  def stored_location_for(resource_or_scope)
    nil
  end

  def after_sign_in_path_for(resource_or_scope)
    return dashboard_path
  end
end
