
  class Users::PasswordsController < Devise::SessionsController
    # before_filter :configure_sign_in_params, only: [:create]

    layout "ancient_backend/login"

    def change_password
      if params[:user][:email].present?
      @user= AncientBackend::User.find_by_email(params[:user][:email])
      if current_identity.in? @user.all_identity_codes
        token = Digest::MD5.hexdigest "#{SecureRandom.hex(10)}"
        @user.email_token = token
        @user.save
        code = current_identity
        @user.change_password_email(@user, code)
        set_flash_message(:alert, :send_instructions)
        redirect_to '/backend/users/sign_in'
      else
        set_flash_message(:alert, :site_error) if is_flashing_format?
        redirect_to '/backend/users/password/new'
      end
    else
      set_flash_message(:alert, :site_email_nil)
      redirect_to '/backend/users/password/new'
    end
  end

 end
