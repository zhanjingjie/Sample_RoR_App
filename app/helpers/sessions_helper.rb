module SessionsHelper
	# The sessions_controller will call this method to sign in a user already in the database
	# Save the remember_token into cookie and set current_user variable.
	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		# Create current_user, accessible in both controllers and views
		# Have to use "self", otherwise Ruby would simply create a local variable 
		self.current_user = user
	end

	def current_user=(user)
		# Store the user for later use
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token] )
	end
end
