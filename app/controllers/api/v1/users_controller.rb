class Api::V1::UsersController < Api::V1::BaseController

  skip_before_action :authenticate

  api :POST, '/v1/user/register', "Create new user"
  param :username, String, :desc => "Username for login", :required => true
  param :firstname, String, :desc => "firstname", :required => true
  param :lastname, String, :desc => "lastname", :required => false
  param :email, String, :desc => "Email for login", :required => true
  param :password, String, :desc => "Password for login", :required => true
  param :password_confirmation, String, :desc => "Confirm Password for login", :required => true
  # param :lang_code, ["en","ar"], :desc => "Select language", :required => true

  def register

    begin
      # Sanitize POST data
      # username = params[:username]
      username = $FullSanitizer.sanitize(params[:username]).downcase
      # Strong Parameters
      parameters = ActionController::Parameters.new(:email => params[:email],
                                                    :password => params[:password],
                                                    :password_confirmation => params[:password_confirmation],
                                                    :firstname => params[:firstname],
                                                    :lastname =>params[:lastname],
                                                    :user_type=>params[:user_type])


      permitted_parameters = parameters.permit(:email,:firstname,:lastname, :password, :password_confirmation,:user_type)


      # Create User
      @user = User.new(permitted_parameters)
      if @user.save!
        # Example:=> render json: { success: true, data: UserSerializer.new(@user) }, :status => 201 if @user.valid?
        render :json => { success: true, message: "User Registered successfully", data:UserSerializer.new(@user) }, :status => 201
      end
    rescue Exception => e      # rescues all exceptions
      # Error Response

      render :json => { success: false,
                        message: e.is_a?(ActiveRecord::RecordInvalid) ? (params[:lang_code] == "en") ? e.record.errors.full_messages[0] : e.record.errors.full_messages[0] : e.message,
                        data: {} }, :status => 400
      logger.error(e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors : e.message)
    end
  end

  def login

    begin
      # ...
      if params[:email].to_s =~ /^.+@.+$/
        @user = User.find_by_email(params[:email])
      else
        @user = User.find_by_email(params[:email])
      end



      if @user && @user.valid_password?(params[:password])

        # Generate New Authentication token if login is success
        @user.ensure_authentication_token!
        # @user.timezone = $FullSanitizer.sanitize(params[:timezone])
        @user.save!
        # Success Response
        render :json => { success: true, message: " you have successfully login", data:UserSerializer.new(@user)}, :status => 200
      else
        # Error Response
        render :json => { success: false, message: "invalid_login_details", data: {} }, :status => 400
      end

    rescue Exception => e      # rescues all exceptions
      # Error Response
      render :json => { success: false,
                        message: e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors.full_messages[0] : e.message,
                        data: {} }, :status => 400
      logger.error(e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors : e.message)
    end
  end
  def update


    begin

      id  = params[:user_id]
      @user = User.find_by(id:id)

      if @user.nil?
        render :json =>{success: false, message:"User does not exists",data: {} },status => 400
      else

        parameters = ActionController::Parameters.new(params)
        permitted_parameters = parameters.permit(:firstname,:lastname)
        @user.update(permitted_parameters)
        if @user.save!
          render :json =>{success:true ,message:"user update successfully",data: UserSerializer.new(@user) }, :status=>200
        end
      end
    rescue Exception => e      # rescues all exceptions
      # Error Response
      render :json => { success: false,
                        message: e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors.full_messages[0] : e.message,
                        data: {} }, :status => 400
      logger.error(e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors : e.message)

    end
  end
  def password


    begin
      id = params[:user_id]
      @user =User.find_by(id:id)
      if @user.valid_password?(params[:current_password])
        render :json =>{success:false ,message:"current password failed",data:{}},status =>200
      else
        parameters = ActionController::Parameters.new(params)
        permitted_parameters = parameters.permit(:password,:password_confirmation)
        @user.update(permitted_parameters)
        if @user.save!
          render :json =>{ success: true,message:"password change successfully",data:{}},status=>200
          return
        end
      end
    rescue Exception => e
      # Error Response
      render :json => { success: false,
                        message: e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors.full_messages[0] : e.message,
                        data: {} }, :status => 400
      logger.error(e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors : e.message)
      return
    end



  end
  def logout
    begin
      #strong parameters
      parameters = ActionController::Parameters.new(:authenication_token=>nil)
      permitted_parameters = parameters.permit(:authenication_token)

      @user =User.find_by_id(params[:user_id])
      if @user.present?
        @user.update
      else
      end
    rescue
    end

  end




  def dummy
    render :json => { success: true, message: "test", data:"tea" }, :status => 201
  end
  def search

    begin
      @search = User.search("#{params[:q]}").records

      render :json => { success: true, message: "Searched result", data:@search.response.results.map{|r| r._source}}, :status => 200
    rescue Exception => e

      # Error Response
      render :json => { success: false,
                        message: e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors.full_messages[0] : e.message,
                        data: {} }, :status => 400
      logger.error(e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors : e.message)
      return
    end
  end
end
