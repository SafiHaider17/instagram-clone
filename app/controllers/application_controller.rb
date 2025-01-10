class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  #after_action :send_welcome_email, only: :create, if: :user_signed_up?

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    posts_path  
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
  end


  # def send_welcome_email
  #   # Send the welcome email after the user registers (signs up)
  #   UserMailer.with(user: current_user).welcome_email(current_user).deliver_later
  # end

  # def user_signed_up?
  #   # Check if the user just signed up
  #   defined?(current_user) && current_user.persisted?
  # end
end
