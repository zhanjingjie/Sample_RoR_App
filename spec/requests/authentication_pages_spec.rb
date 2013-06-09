require 'spec_helper'

describe "Authentication" do
	subject { page }

  describe "authorization" do
    let(:user) {FactoryGirl.create(:user)}
    describe "in the Users controller" do
      describe "visiting the edit page" do
        before { visit edit_user_path(user) }
        it { should have_selector('title', text: 'Sign in') }
      end
      describe "submitting to the update action" do
        before { put user_path(user) }
        specify { response.should redirect_to(signin_path) }
      end
    end

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end
        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end
  end

	describe "signin page" do 
		before { visit signin_path }
		it { should have_selector('h1', text: 'Sign in') }
		it { should have_selector('title', text: 'Sign in') }
  	end

  	describe "signin" do
  		# The sign up form page
  		before { visit signin_path }

  		describe "with invalid information" do
  			before { click_button "Sign in" }
  			it { should have_selector('title', text: 'Sign in') }
        # The RSpec helper method is in spec utitlities
  			it { should have_error_message('Invalid') }

  			# A nested test
  			describe "after visiting another page" do
  				before { click_link "Home" }
  				it { should_not have_error_message('Invalid') }
  			end
  		end

  		describe "with valid information" do
  			let(:user) { FactoryGirl.create(:user) }
        # The helper method is in spec utilities
  			before { sign_in user }
  			it { should have_selector('title', text: user.name) }
  			it { should have_link('Profile', href: user_path(user)) }
        it { should have_link('Settings', href: edit_user_path(user)) }
  			it { should have_link('Sign out', href: signout_path) }
  			it { should_not have_link('Sign in', href: signin_path) }

        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end 
  		end
  end
end
