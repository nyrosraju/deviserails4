class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
   before_filter :configure_permitted_parameters, if: :devise_controller?


def after_sign_in_path_for(resource_or_scope)
      profile_path(current_user)
end

def after_sign_out_path_for(resource_or_scope)
  new_user_session_path
end


  protected

  #def configure_permitted_parameters
  #  devise_parameter_sanitizer.for(:sign_up) << :username
  #end 
  def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation,:location) }
   
    #devise_parameter_sanitizer.for(:sign_up) do |u|
    #  u.permit(:username,:password,:password_confirmation)
    #end
    #devise_parameter_sanitizer.for(:sign_in) do |u|
    #  u.permit(:username,:email,:password,:password_confirmation,:phone, :validate_username, :avatar_cache, :remove_avatar, :current_password,:remember_me)
    #end

    #devise_parameter_sanitizer.for(:sign_in) do |u|
    #  u.permit(:username,:email,:password,:password_confirmation,:phone, :validate_username, :avatar_cache, :remove_avatar, :current_password,:remember_me)
    #end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:username,:email,:password,:password_confirmation,:location, :current_password)
    end
   
   
   
end
  
end
