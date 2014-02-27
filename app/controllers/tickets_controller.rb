class TicketsController < ApplicationController
  include Modules::Charts
  before_filter :set_subject, only: [:new, :create]
  before_filter :set_user, only: [:new, :create]
  before_filter :set_to_close

  def index
    if params[:tab] == "open"
      @tickets = Ticket.opened
      mini_charts
    elsif params[:tab] == "solved"
      @tickets = Ticket.solved
      mini_charts
    elsif params[:tab] == "assigned"
      if current_user.staff?
        @tickets = Ticket.joins(:ticket_statuses).where("ticket_statuses.staff_id = ?", current_user.employee.id)
        mini_charts
      elsif current_user.advisor?
        @tickets = Ticket.joins(:ticket_statuses).where("ticket_statuses.advisor_id = ?", current_user.employee.id)
        mini_charts
      end
    elsif params[:tab] == "overdue"
      @tickets = Ticket.overdue
      mini_charts
    elsif params[:tab] == "closed"
      @tickets = Ticket.closed
      mini_charts
    elsif params[:tab] == "complained"
      if current_user.student?
        @tickets = Ticket.where("student_id = ?", current_user.student.id)
      end
    else
      render_404
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
    @status_title = Status.joins(ticket_statuses: :ticket).where("tickets.id = ?", @ticket.id).first
    @subject_title = Subject.find_by_sql("SELECT subject_title FROM subjects, tickets
    WHERE subjects.id = tickets.subject_id AND tickets.id = #{@ticket.id}") 
    @assigned_advisor = Advisor.joins(ticket_statuses: :ticket).where("tickets.id = ? ", @ticket.id).first
    @assigned_staff = Staff.joins(ticket_statuses: :ticket).where("tickets.id = ? ", @ticket.id).first
    @follow_up = FollowUp.new
    @response = Response.new
    @responses = Response.all
    if !@ticket.ticket_statuses.first.versions.last.object.nil?
      previous_advisor = @ticket.ticket_statuses.first.previous_version.advisor_id
      previous_advisor = Advisor.where("employees.id = ?",previous_advisor).first
      if previous_advisor.nil?
        @previous_advisor = nil
      else
        @previous_advisor = previous_advisor.full_name
      end
      previous_staff = @ticket.ticket_statuses.first.previous_version.staff_id
      previous_staff = Staff.where("employees.id = ?", previous_staff).first
      if previous_staff.nil?
        @previous_staff = nil
      else
        @previous_staff = previous_staff.full_name
      end
       updated_by = @ticket.ticket_statuses.first.versions.last.whodunnit
       if updated_by.nil?
          @updated_by = 'The System'
        else
          @updated_by = User.find(updated_by).employee.full_name
        end
       @update_date = @ticket.ticket_statuses.first.versions.last.created_at.strftime("%d/%m/%Y %I:%M%p")
    end
    respond_to do |format|
      format.html # show.html.erb
      format.js # show.js.erb
      format.json { render json: @ticket }
    end
  end


  def new
    @ticket = Ticket.new
    @ticket.ticket_statuses.build
    respond_to do |format|
      format.html # new.html.erb
      format.js # new.js.erb
      format.json { render json: @ticket }
    end
  end

  def create
    @ticket = Ticket.new(params[:ticket])
    if @ticket.save
      if @ticket.priority.priority_name == "#{TicketsController::HIGH}"
        due = @ticket.create_at.to_date + 2.days
        @ticket.update_attributes(due: due)
      elsif @ticket.priority.priority_name == "#{TicketsController::NORMAL}"
        due = @ticket.create_at.to_date + 7.days
        @ticket.update_attributes(due: due)
      elsif @ticket.priority.priority_name == "#{TicketsController::LOW}"
        due = @ticket.create_at.to_date + 10.days
        @ticket.update_attributes(due: due)
      end
      advisor = SubjectStaff.where(subject_id: @ticket.subject_id).first
      TicketStatus.create(status_id: 1,ticket_id: @ticket.id, advisor_id: advisor.advisor_id )
      redirect_to subjects_path(tab: 'enrolled')
    else
      redirect_to subjects_path(tab: 'enrolled')
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      redirect_to ticket_path(@ticket)
    else
      render 'edit'
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
  end

  def assign
    @ticket = Ticket.find(params[:id])
    @ticket.ticket_statuses.first.update_attributes(staff_id: current_user.employee.id)
    redirect_to @ticket
  end

  private
  def set_subject
    @title = Subject.find(params[:subject_id]).subject_title
    @subject = Subject.find(params[:subject_id]).id
  end

  def set_user
    if current_user.student
      @student = current_user.student.id
      @name  = Student.find(@student)
      @batch = @name.batch
      @section = @name.section
      @today = Date.today
    end
  end

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