class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			# Sign the user in and redirect to the user's show page
			sign_in user # A helper function
			redirect_to user
		else 
			# will pass the flash variable to the view
			flash.now[:error] = 'Invalid email/password combination' # Not quite right
			render 'new'
		end
	end

	def destroy
	end
end
