# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  #	helper :all # include all helpers, all the time

  #	protect_from_forgery # :secret => 'd4eb7f12c33fd13842c319d0561a08e1'
  
	require "yaml"

	before_filter :authorise, :except => ["index"]

	def authorise
		if session[:username].nil?
			redirect_to(:controller => "user", :action => "index")
		end
	end
end
