class RepliesController < ApplicationController
	before_filter :load_suggestion

	def create
		@reply = @suggestion.replies.build(params[:reply])
		@reply.user = current_user
		if @reply.save
			flash[:notice] = "Reply has been added."
			redirect_to @suggestion
		else
			flash[:alert] = "An error occurred please try again!"
			redirect_to @suggestion
		end
	end



	private

	def load_suggestion
		@suggestion = Suggestion.find(params[:suggestion_id])
	end
end
