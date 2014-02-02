class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  protect_from_forgery
  before_filter :find_priority
  before_filter :set_to_close

  def find_priority
    @priorities = Priority.all
  end

  def render_404
    render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
  end
  
  def set_to_close
    @tickets = Ticket.overdue
    @tickets.each do |ticket|
      if ticket.statuses.ticket_status != 'Solved' && ticket.due < Date.today
        ticket.statuses.update_attributes(ticket_status: "Closed")
        ticket.ticket_statuses.update_attributes(staff_id: nil)
      end
    end
  end

  private

  def stored_location_for(resource_or_scope)
    nil
  end

  def after_sign_in_path_for(resource_or_scope)
    if current_user.admin?
      return users_path
    elsif current_user.head_of_department?
      return dashboard_path
    elsif current_user.staff?
      return tickets_path(tab: "open")
    elsif current_user.advisor?
      return subjects_path(tab: "assigned")
    elsif current_user.student?
      return subjects_path(tab: "enrolled")
    end
  end
end
