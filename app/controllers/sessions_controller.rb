class SessionsController < ApplicationController
 	  before_filter :set_user, only: [:profile, :profile_update]#, :except => [:index, :create]
 	def home
		#Home Page
	end
 	
 	def profile
		#Profile Page
		#@user = current_user
		#render json: @user
	end
 	

  private

  def set_user
    @user = User.find(current_user)
  end

  def user_params
    params.require(:user).permit(:username, :email, :firstname, :lastname, :hometown, :highschool, :city, :state,:college, :occupation, :address, :postalcode)
  end 	
 
	
 	
end
