class ProfilesController < ApplicationController
  before_filter :set_user, only: [:show]#, :except => [:index, :create]

 	
 	def show
		#Profile Page
		#@user = current_user
		#render json: @user
	end
 	
  	
 	def profile_update
	 puts "sssssssssssssssssssss"
	 puts "----#{params[:val]}------------------"
	 @user = User.find(params[:val][:id])
	 @user.update_attributes(userparams)
	 #redirect_to profile_path(@user.id), :flash => {:error => "Profile as been updated sucessfully"}
	     respond_to do |format|
      format.html { redirect_to :back, :flash => {:notice => "Profile as been updated sucessfully"} }
      format.js
    end
	 
	end
 		
 	
  private

  def set_user
    @user = User.find(current_user)
  end

  def user_params
    params.require(:user).permit(:username, :email)
  end
  
    def userparams
    params.require(:val).permit(:firstname, :lastname, :hometown, :highschool, :city, :state,:college, :occupation, :address, :postalcode)
  end  
end
