class Api::V1::BaseController < ApplicationController
       


       # Add below line to make AWS work with rails-api 
					# include ActionController::Serialization
					
					# Global variable to sanitize form post data
					 $FullSanitizer = Rails::Html::FullSanitizer.new

					# Check for logged in user on every API call
				 	before_action :authenticate

					protected
						# Common functions
						
						def authenticate			
							# Check if user is guest or registered user
							if params[:user_id].to_i > 0
								user_id = (params[:user_id] == 0) ? params[:access_token] : params[:user_id] 
					      # prevToken = $redis.get("user_#{user_id}_authentication_token") 
					      # if prevToken.nil? 
					      	user = User.find_by_id(user_id)
					      	unless user.nil? 
						      	# prevToken = user.authentication_token
						      	# $redis.set("user_#{user_id}_authentication_token", prevToken)
						      end
					      # end

					      render :json => { success: false, message: params[:lang_code] == "en" ? "Unauthorized. Invalid or expired token." : "لم يتم إنجاز الأمر.. حاول مرة أخرى بعد التأكد من البيانات", data: {} }, :status => 400 unless prevToken == params[:access_token]
					  	end
						end

				    def current_user
				    	@current_user = User.find_by_id(params[:user_id])
				    	if @current_user.nil?
				    		render :json => { success: false, message: "User doesn't exist in database!!!", data: {} }, :status => 400 
				    	end
				    end	


end
