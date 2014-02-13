class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  include Modules::DefaultValues
  protect_from_forgery
  #before_filter :set_start_time
  before_filter :find_priority
  #before_filter :set_to_close


  def set_start_time
    @start_time = Time.now.usec
    # Page Rendered in <%= sprintf('%.3f', (Time.now.usec - @start_time).abs / 1000000.0) %> seconds
  end

  def find_priority
    @priorities = Priority.all
  end

  def render_404
    render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
  end
  
  # def set_to_close
  #   tickets = Ticket.overdue
  #   tickets.each do |ticket|
  #     # if (ticket.statuses.first.ticket_status != "#{ApplicationController::SOLVED}") && (ticket.due < Date.today)
  #     #        subject_id = ticket.subject_id
  #     #        advisor_id = ticket.ticket_statuses.first.advisor_id
  #     #        staff = SubjectStaff.where("subject_id = ? AND advisor_id = ?", subject_id , advisor_id).first
  #     #        staff_id = staff.staff_id if staff_id != nil
  #     #        #ticket.statuses.first.update_attributes(ticket_status: "#{ApplicationController::CLOSED}")
  #     #        ticket.ticket_statuses.first.update_attributes(staff_id: staff_id, advisor_id: nil)
  #     #      els
  #     if (ticket.statuses.first.ticket_status != "#{ApplicationController::SOLVED}") && (ticket.due < Date.today)
  #         subject_id = ticket.subject_id
  #         staff = SubjectStaff.where("subject_id = ?", subject_id).first
  #         staff_id = staff.staff_id
  #         #ticket.statuses.first.update_attributes(ticket_status: "#{ApplicationController::CLOSED}")
  #         ticket.ticket_statuses.first.update_attributes(staff_id: staff_id, advisor_id: nil)
  #     end
  #   end
  # end

  private

  def stored_location_for(resource_or_scope)
    nil
  end

  def after_sign_in_path_for(resource_or_scope)
    if current_user.admin?
      return users_path(tab: 'all')
    elsif current_user.head_of_department?
      return dashboard_path
    elsif current_user.staff?
      return home_path
    elsif current_user.advisor?
      return home_path
    elsif current_user.student?
      return subjects_path(tab: "enrolled")
    end
  end
end
