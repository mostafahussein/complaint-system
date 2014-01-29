class FollowUpsController < ApplicationController
  before_filter :load_ticket

  def create
    @follow_up = @ticket.follow_ups.build(params[:follow_up])
    @follow_up.user = current_user
    if @follow_up.save
      flash[:notice] = "Comment has been created."
      redirect_to @ticket
    else
      flash[:alert] = "Comment has not been created."
      redirect_to @ticket
    end
  end



  private

  def load_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
end
