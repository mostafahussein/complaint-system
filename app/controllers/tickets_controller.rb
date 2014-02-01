class TicketsController < ApplicationController
  before_filter :set_subject, only: [:new, :create]
  before_filter :set_user, only: [:new, :create]
  
  def index
    if params[:tab] == "open"
      @tickets = Ticket.opened
    elsif params[:tab] == "solved"
      @tickets = Ticket.solved
    elsif params[:tab] == "assigned"
      if current_user.staff?
        @tickets = Ticket.joins(:ticket_statuses).where("ticket_statuses.staff_id = ?", current_user.employee.id)
      elsif current_user.advisor?
        @tickets = Ticket.joins(:ticket_statuses).where("ticket_statuses.advisor_id = ?", current_user.employee.id)
      end
    elsif params[:tab] == "overdue"
      @tickets = Ticket.overdue
    elsif params[:tab] == "closed"
      @tickets = Ticket.closed
    elsif params[:tab] == "complained"
      if current_user.student?
        @tickets = Ticket.("student_id = ?", current_user.student.id)
      end
    else
      render_404
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
    @status_title = Status.joins(ticket_statuses: :ticket).where("tickets.id = ?", @ticket.id).first
    @subject_title = Subject.joins(advisor: {ticket_statuses: :ticket}).where("tickets.subject_id = subjects.id 
    AND subjects.id = ? AND tickets.id = ?", @ticket.subject_id , @ticket.id ).first
    @assigned_advisor = Advisor.joins(ticket_statuses: :ticket).where("tickets.id = ? ", @ticket.id).first
    @assigned_staff = Staff.joins(ticket_statuses: :ticket).where("tickets.id = ? ", @ticket.id).first
    @follow_up = FollowUp.new
  end


  def new
    @ticket = Ticket.new
    @ticket.ticket_statuses.build
  end

  def create
    @ticket = Ticket.new(params[:ticket])
    if @ticket.save
      if @ticket.priority.priority_name == 'High'
        due = @ticket.create_at.to_date + 2.days
        @ticket.update_attributes(due: due)
      elsif @ticket.priority.priority_name == 'Normal'
        due = @ticket.create_at.to_date + 7.days
        @ticket.update_attributes(due: due)
      elsif @ticket.priority.priority_name == 'Low'
        due = @ticket.create_at.to_date + 10.days
        @ticket.update_attributes(due: due)
      end
      subject = Subject.find(params[:subject_id])
      @advisor = subject.employee
      TicketStatus.create(status_id: 1,ticket_id: @ticket.id, advisor_id: @advisor.id )
      redirect_to attended_subjects_path
    else
      redirect_to attended_subjects_path
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
    end
  end
  
end
