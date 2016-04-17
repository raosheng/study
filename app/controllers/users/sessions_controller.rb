
  class Users::SessionsController < Devise::SessionsController
    # before_filter :configure_sign_in_params, only: [:create]

    layout "ancient_backend/login"
    # GET /resource/sign_in
    def new
      super
    end

    # POST /resource/sign_in
    def create
      self.resource = warden.authenticate!
      if self.resource.status == 'frozen'
        set_flash_message(:alert, :user_frozen) if is_flashing_format?
        sign_out(resource)
        redirect_to new_user_session_path
        return
      end
      unless current_identity.in? resource.all_identity_codes
        if !(resource.company.is_supplier? && current_identity == 'sinopr')
          set_flash_message(:alert, :site_error) if is_flashing_format?
          sign_out(resource)
          redirect_to new_user_session_path
          return
        end
      end
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end

    #DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    # protected

    # You can put the params you want to permit in the empty array.
    def configure_sign_in_params
      devise_parameter_sanitizer.for(:sign_in) << :attribute
    end

    private
    def after_sign_in_path_for(resource)
      '/' #不能写root_path
    end

   def after_sign_out_path_for(resource)
      '/'
   end
   
  end


