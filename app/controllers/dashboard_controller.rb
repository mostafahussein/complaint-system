class DashboardController < ApplicationController
  before_filter :set_to_close
  include Modules::Charts
  def index
    yearly_chart
    tickets_with_statuses
    tickets_with_priorities
    advisors_statistics
    staff_statistics
    complaints_statistics
    subjects_statistics
    start_end
    mini_charts
  end
  private
  def set_to_close
     tickets = Ticket.overdue
     tickets.each do |ticket|
       if (ticket.statuses.first.ticket_status != "#{ApplicationController::SOLVED}") && (ticket.due < Date.today)
           subject_id = ticket.subject_id
           staff = SubjectStaff.where("subject_id = ?", subject_id).first
           staff_id = staff.staff_id
           #ticket.statuses.first.update_attributes(ticket_status: "#{ApplicationController::CLOSED}")
           ticket.ticket_statuses.first.update_attributes(staff_id: staff_id, advisor_id: nil)
       end
     end
   end
end
