class ApplicationController < ActionController::API

	after_action :cors_set_access_control_headers

  


  # Action to follow routes with HTTP verb 'OPTIONS'
  def cors
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
    headers['Access-Control-Max-Age'] = '1728000'

    render text: '', content_type: 'text/plain'
  end

  # This method will set the access control header accordingly after each action performed.
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end
     def set_locale
          I18n.locale = params[:lang_code] || I18n.default_locale
      end

    # Handle InvalidLocale errors
    rescue_from I18n::InvalidLocale do |e|
      render json: { success: false, message: e.message, data: {} }, status: 400
    end 

    # Handle Apipie::ParamMissing errors
    rescue_from Apipie::ParamError do |e|
      render json: { success: false, message: e.message, data: {} }, status: 400
    end

   def return_500_error
    render json: { success: false, error: I18n.t('errors.e_500'),
                   status_code: 500 }, status: :internal_server_error
   end

    # This method will return JSON error message with 404 status code when rails app
    # throw not found error.
    def return_404_error

      render json: { success: false, error: I18n.t('errors.e_404'),
                     status_code: 404 }, status: :not_found
    end

    # This method will return JSON error message with 400 status code when rails app
    # throw bad request error.
    def return_400_error
      render json: { success: false, error: I18n.t('errors.e_400'),
                     status_code: 400 }, status: 400
    end



end
