
  class Users::RegistrationsController < Devise::RegistrationsController
    prepend_before_filter :require_no_authentication, only: [:new, :create]
    layout "ancient_backend/register"
    # GET /resource/sign_up
    def new
      build_resource({})
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      gon.currentUserId = resource.id
    end

    # POST /resource
    def create
      build_resource(sign_up_params)
      @center = AncientBackend::Personality.find_by(code: current_identity).center
      supplier = resource.roles.map(&:name).include?("供应商管理员")
      purchaser = resource.roles.map(&:name).include?("采购单位管理员")
      gr = resource.roles.map(&:name).include?("个人采购")

      if supplier
        save_company("AncientBackend::Supplier", "supplier_first")
      elsif purchaser
        save_company("AncientBackend::Purchaser", "purchaser_first")
      elsif gr
        if @center.id == 11337 && params['reg-parent-id'].values.last.present?
          role = AncientBackend::Role.find_by(:name => '采购员')
          resource.roles = []
          resource.roles << role
          @company = @center.approved_purchasers.find_by(:id => params['reg-parent-id'].values.last.to_i)
        else
          @company = @center.approved_purchasers.is_personal.first
        end
      end
      AncientBackend::User.transaction do
        if supplier || purchaser
          passport_block AncientBackend::CentersPurchasers, :status_of_custom, 'sign_up_non_completed' do
            passport_block AncientBackend::CentersSuppliers, :status_of_custom, 'sign_up_non_completed' do
              @company.save!
            end
          end
        end
        resource.company_id = @company.id
      if @center.id == 332224
        resource.status = gr ? 'waiting_audit' : 'sign_up_non_completed'
      else
        resource.status = gr ? 'audit_approved' : 'sign_up_non_completed'
      end
        resource.save!
      end
      sign_up(resource_name, resource)
      if supplier
        redirect_to supplier_after_signup_path(@step)
      elsif purchaser
        redirect_to purchaser_after_signup_path(@step)
      elsif gr
        redirect_to '/mall/home/flash_show'
      end

      # flash_msg(:error, resource.errors.values.flatten.join(' '))
      # clean_up_passwords resource
      # @validatable = devise_mapping.validatable?
      # if @validatable
      #   @minimum_password_length = resource_class.password_length.min
      # end
    end

    def save_company(clazz, value)
      @step = value
      @company = eval(clazz).new(company_params)
      @company.centers << @center
      @company.supplier_status = 'sign_up_non_completed' if clazz == "AncientBackend::Supplier"
      @company.purchaser_status = 'sign_up_non_completed' if clazz == "AncientBackend::Purchaser"
    end

  
    def change_password_email
      if params[:email_token].present?
      @user = AncientBackend::User.find_by_email_token(params[:email_token])
      end
     end

     def do_change_password
       @user = AncientBackend::User.find_by_email_token(params[:email_token])
       if @user.present?
       @user.update(sign_up_params)
       token = Digest::MD5.hexdigest "#{SecureRandom.hex(10)}"
       @user.update(email_token: token)
       set_flash_message(:alert, :password)
       redirect_to '/backend/users/sign_in'
     else
       set_flash_message(:alert, :cat_email)
       redirect_to '/backend/users/password/new'
      end
     end

    def check_uniq
      boolean=case params[:field]
                when "org_code"
                  AncientBackend::Company.exists?(['org_code = ? and id !=?', params[:fieldValue], params[:current_company_id]])
                # 用户邮箱验证
                when "user_email"
                  AncientBackend::User.exists?(['email = ? and id != ?', params[:fieldValue], params[:current_user_id]])
                # 用户登录名验证
                when "login_name"
                  AncientBackend::User.exists?(['login_name = ?', params[:fieldValue]])
                # 单位验证
                when "company_name"
                  AncientBackend::Company.exists?(['name = ?', params[:fieldValue]])
                # 员工编号验证
                when "employee_num"
                  AncientBackend::User.exists?(['employee_num = ?', params[:fieldValue]])
              end
      render text: [params[:fieldId], !boolean]
    end

    # 通用级联下拉框
    def selects
      clazz = params[:otype].to_s.singularize.camelize.constantize
      if clazz.respond_to?(:published)
        @objects = params[:id].blank? ? clazz.published.all : clazz.children_of(params[:id]).published
      else
        @objects = params[:id].blank? ? clazz.all : clazz.children_of(params[:id])
      end
      @objects.delete_if { |obj| params[:reject_ids].to_s.split(",").include?(obj.id.to_s) } if params[:reject_ids].present? && @objects.present?
      if params[:otype].blank? or @objects.empty? or params[:id].blank?
        render :nothing => true
      else
        render :partial => "ancient_backend/shared/reg_selects", :layout => false
      end
    end

    protected

    # The path used after sign up. You need to overwrite this method
    # in your own RegistrationsController.
    def after_sign_up_path_for(resource)
      after_sign_in_path_for(resource)
    end

    def sign_up_params
      params.require(:user).permit(:login_name, :real_name, :employee_num, :tel, :email, :password, :password_confirmation, :role_ids)
    end

    def company_params
      params.require(:company).permit(:name, :org_code, :is_enterprise)
    end

    def sign_up(resource_name, resource)
      sign_in(resource_name, resource)
    end

    def build_resource(hash=nil)
      self.resource = resource_class.new_with_session(hash || {}, session)
    end

  end
