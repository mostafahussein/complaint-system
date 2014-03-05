class SuggestionsController < ApplicationController
	before_filter :set_subject, only: [:new, :create]
	before_filter :set_user, only: [:new, :create]
	
	def index
		@suggestions = Suggestion.all
	end

	def show
		
	end


	def new
		@suggestion = Suggestion.new
		respond_to do |format|
      		format.html # new.html.erb
      		format.js # new.js.erb
      		format.json { render json: @suggestion }
      	end
      end

      def create
            @suggestion = Suggestion.new(params[:suggestion])
            if @suggestion.save
                  redirect_to  subjects_path(tab: "enrolled"), notice: "Suggestion Created."
            else
                  redirect_to  subjects_path(tab: "enrolled"), notice: "Something went wrong."
            end
      end

      def vote_up
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
          end
    end
end
