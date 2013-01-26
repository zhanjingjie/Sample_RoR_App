module SessionsHelper
	# The sessions_controller will call this method to sign in a user already in the database
	# Save the remember_token into cookie and set current_user variable.
	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		# Create current_user, accessible in both controllers and views
		# Have to use "self", otherwise Ruby would simply create a local variable 
		self.current_user = user
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	# Helper used by the view to test if the user is signed in
	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		# Store the user for later use
		@current_user = user
	end

	def current_user
		# @current_user. With this code the signin status would be forgotten when going to another page.
		# "or equal" will set the instance variable only if it is undefined.
		# So won't hit the database very often. Good if more than one requests on a page.
		@current_user ||= User.find_by_remember_token(cookies[:remember_token] )
	end
end
