# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  after_action :send_welcome_email, only: :create, if: :user_signed_up?
    private

  # Send the welcome email
  def send_welcome_email
    UserMailer.with(user: current_user).welcome_email(current_user).deliver_later
  end


  def user_signed_up?
    # Check if the user just signed up
    defined?(current_user) && current_user.persisted?
  end


end



