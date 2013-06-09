class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			# Sign the user in and redirect to the user's show page
			sign_in user # A helper function
			redirect_back_or user
		else 
			# will pass the flash variable to the view. flash.now will show flash on current request
			flash.now[:error] = 'Invalid email/password combination' 
			render 'new'
		end
	end

	def destroy
		# Rely on the helper function
		sign_out
		redirect_to root_path
	end
end
