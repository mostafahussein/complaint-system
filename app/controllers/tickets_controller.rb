class TicketsController < ApplicationController
  before_filter :set_subject, only: [:new, :create]
   before_filter :set_user, only: [:new, :create]
 	def index
 	  if params[:tab] == "open"
 	    @tickets = Ticket.opened
    elsif params[:tab] == "solved"
      @tickets = Ticket.solved
    elsif params[:tab] == "assigned"
      render_404
    elsif params[:tab] == "overdue"
      render_404
    elsif params[:tab] == "closed"
      @tickets = Ticket.closed
    else
      render_404
    end
   end

   def show
     @ticket = Ticket.find(params[:id])
   end


   def new
     @ticket = Ticket.new
     @ticket.ticket_statuses.build
     @ticket.follow_ups.build
   end

   def create
     @ticket = Ticket.new(params[:ticket])
     if @ticket.save
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
   
   def assgin_me
     @ticket = Ticket.find(params[:id])
     @ticket.ticket_statuses.each do |ticket|
       ticket.update_attributes(staff_id: current.employee.id)
     end
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
