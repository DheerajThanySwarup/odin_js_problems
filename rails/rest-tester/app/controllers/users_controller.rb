class UsersController < ApplicationController

	def index
		@name = "Iam the Index action"
	end

	def edit
		@name = "Iam the Edit action" 
	end

	def new
		@name = "Iam the New action"
	end

	def show
		@name = "Iam the Show action"
	end

	def create

	end

end
