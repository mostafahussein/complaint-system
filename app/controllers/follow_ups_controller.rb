class FollowUpsController < ApplicationController
  before_filter :load_ticket

  def create
    @follow_up = @ticket.follow_ups.build(params[:follow_up])
    @follow_up.user = current_user
    if @follow_up.save
      flash[:notice] = "Followup has been added."
      redirect_to @ticket
    else
      flash[:alert] = "An error occurred please try again!"
      redirect_to @ticket
    end
  end



  private

  def load_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
end
