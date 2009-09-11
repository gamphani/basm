class UserController < ApplicationController
	def index

		if request.get?
			session[:username] = nil
		else
			@user = User.find(:first, :conditions => ["uname = ? AND passwd = ?", params[:user][:uname], params[:user][:passwd] ])
			
			if @user.blank?
				session[:username] = nil
				flash[:notice] = '<font color="red" type="arial" size=2><center>Enter username/password correctly.</center></font>'
			else
				session[:username] = @user.uname
				redirect_to(:controller => "server", :action => "list")
			end
		end
		
	end

	def create
		if params[:user][:uname].blank?
			flash[:notice] = "<font color=red size=1 type=arial>You did not supply any username.</font>"
			redirect_to(:action => 'new')
		else
			@user = User.find(:first, :conditions => ["uname = ?", params[:user][:uname]])
			if @user.blank?
				@user = User.new(params[:user])
				if @user.save
					redirect_to(:controller => "server", :action => "list")
				else
					flash[:notice] = "<font color=red size=1 type=arial>The user wasn't registered. Please try again.</font>"
					redirect_to(:action => 'new')
				end
			else
				flash[:notice] = "<font color=red size=1 type=arial>User with that username already exists.</font>"
				redirect_to(:action => 'new')
			end
		end
	end
end
