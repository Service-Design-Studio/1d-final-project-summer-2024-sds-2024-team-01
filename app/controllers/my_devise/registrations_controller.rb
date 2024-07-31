# app/controllers/my_devise/registrations_controller.rb
class MyDevise::RegistrationsController < Devise::RegistrationsController
  def choose_register_method; end

  def create
    # add custom create logic here
    build_resource(sign_up_params)
    puts sign_up_params

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      flash[:notice] = resource.errors.full_messages
      redirect_to "/register/user"
    end
  end

  def corporate
    @resource = Company.new
    @userresource = User.new
  end

  def create_corporate
    @company = Company.new
    @company.company_name = params[:company_name]
    @company.status = 'Pending'
    @company.document_proof = params[:document_proof]

    @corpuser = User.new
    @corpuser.email = params[:email]
    @corpuser.name = params[:company_name]
    @corpuser.role_id = 3
    @corpuser.number = nil
    @corpuser.status = 'Inactive'
    @corpuser.password = 'password'
    @corpuser.password_confirmation = 'password'

    ActiveRecord::Base.transaction do
      if @company.save
        @company.document_proof.attach(params[:document_proof])
        puts @company.id
        @corpuser.company_id = @company.id
        if @corpuser.save
          redirect_to '/register/companysuccess'
        else
          @corpuser.errors.full_messages
          redirect_to '/register/corporate', notice: 'Failed to register user'
          raise ActiveRecord::Rollback
        end
      else
        redirect_to '/register/corporate', notice: 'Failed to register'
      end
    end
  end

  def charity
    @resource = Charity.new
  end

  def create_charity
    @resource = Charity.new(charity_params)
    if @resource.save
      @resource.docoument_proof.attach(params[:document_proof])
    else
      render :charity_success_page
    end
  end

  private

  def company_params
    params.permit(:company_name, :document_proof, :email)
  end

  def charity_params
    params.require(:charity).permit(:charity_name, :document_proof)
  end
end
