class DashboardController < ApplicationController
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
end
