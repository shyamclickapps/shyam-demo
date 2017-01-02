class Api::V1::GalleryController < Api::V1::BaseController
        
        before_action :authenticate, except: [:addgallery,:index]  
        # get /v1/gallery/
	      def index
            begin
	   	        @gallerylist = Gallery.all
	   	        # @gallerylist =  Gallery.includes(:gallery_photos).where("galleries.id =gallery_photos.gallery_id").references(:gallery_photos)
 	   	        
 	   	        render :json => { success: true, message: "success", data:ActiveModel::ArraySerializer.new(@gallerylist, each_serializer: GallerySerializer)}, :status => 201

            rescue
            	# Error Response
				        render :json => { success: false, 
				                          message: e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors.full_messages[0] : e.message,
				                          data: {} }, :status => 400
								logger.error(e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors : e.message)
            end 	
	       end 
	        api :POST, 'v1/gallery/addgallery', "Create new user"
          param :galleryname, String, :desc => "Gallery Name", :required => true
          param :gallerydesc, String, :desc => "Gallery Description", :required => true
          param :avatar, ActionDispatch::Http::UploadedFile, :desc => "Gallery photo", :required => false
          param :userid, String, :desc => "Current User ID", :required => true
          param :token,String, :desc=>"authenticationtoken",:required =>true	       
        # POST /v1/gallery/addgallery/
	      def addgallery
	      		# skip_before_action :authenticate
	      	  begin
	   	        galleryname = $FullSanitizer.sanitize(params[:galleryname]).downcase
					      # Strong Parameters
					    parameters = ActionController::Parameters.new(:name => galleryname,
					  	              :description => params[:gallerydesc], 
					  	              :avatar => params[:avatar], 
					  	              :user_id => params[:userid])					  
					    permitted_parameters = parameters.permit(:name,:description,:avatar, :user_id)					     
					    @gallery = Gallery.new(permitted_parameters)
						  if @gallery.save!
						 	      # Example:=> render json: { success: true, data: UserSerializer.new(@user) }, :status => 201 if @user.valid?
						        render :json => { success: true, message: "success", data:@gallery }, :status => 201 
						 	end
            rescue
            	# Error Response
				        render :json => { success: false, 
				                          message: e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors.full_messages[0] : e.message,
				                          data: {} }, :status => 400
								logger.error(e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors : e.message)
            end    
	      end	
	        api :POST, 'v1/gallery/addphotos', "Add photos to album"
          param :name, String, :desc => "Gallery Name", :required => true
          param :description, String, :desc => "Gallery Description", :required => true
          param :avatar, ActionDispatch::Http::UploadedFile, :desc => "Gallery photo", :required => false
          param :gallery_id, String, :desc => "Current User ID", :required => true
       
        # POST /v1/gallery/addphotos/
				def addphotos         
						begin
			 				photoname = $FullSanitizer.sanitize(params[:name]).downcase
							# Strong Parameters
							parameters = ActionController::Parameters.new(:name => photoname,
													:description => params[:description],
													:avatar => params[:avatar],
													:gallery_id =>params[:gallery_id])
							permitted_parameters = parameters.permit(:name,:description,:avatar, :gallery_id)
							@galleryphtos = GalleryPhoto.new(permitted_parameters)
							if @galleryphtos.save!
										# Example:=> render json: { success: true, data: UserSerializer.new(@user) }, :status => 201 if @user.valid?
										render :json => { success: true, message: "success", data:@galleryphtos }, :status => 201 
							end
						rescue
								# Error Response
								render :json => { success: false, 
								message: e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors.full_messages[0] : e.message,
								data: {} }, :status => 400
								logger.error(e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors : e.message)
						end
				end
				# GET /v1/gallery/getalbumphotos/:gallery_id
				def getalbumphotos				  	
            begin
          	    @photolist = GalleryPhoto.where("gallery_id='#{params[:gallery_id]}'")            	    
			          render :json => { success: true, message: "success",
			           data:ActiveModel::ArraySerializer.new(@photolist, each_serializer: GalleryPhotoSerializer)},
			            :status => 201
            rescue
          	  # Error Response
								render :json => { success: false, 
								message: e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors.full_messages[0] : e.message,
								data: {} }, :status => 400
								logger.error(e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors : e.message)
            end 	
				end
				#PUT /v1/gallery/updategallery/

				def updategallery
            begin            	 
          	  id  = params[:id]
	        	  @gallery = Gallery.find_by(id:id)		        	  
	        	   if @gallery.nil?		        	  	
				 	   	 	   render :json =>{success: false, message:"gallery does not exists",data: {} },status => 400
				 	   	 else 
				 	   	 	   parameters = ActionController::Parameters.new(params)
				 	   	 	   permitted_parameters = parameters.permit(:name,:description)
				 	   	 	   @gallery.update(permitted_parameters)
				 	   	 	   if @gallery.save!
				 	   	 	   	render :json =>{success:true ,message:"Gallery update successfully",data: @gallery }, :status=>200
				 	   	 	   end 	
				       end
	          rescue
        	     # Error Response
								render :json => { success: false, 
								message: e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors.full_messages[0] : e.message,
								data: {} }, :status => 400
								logger.error(e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors : e.message)
	          end 	
				end 
				def updategalleryphotos
					  begin
				  	  id  = params[:id]
	        	  @photolist = GalleryPhoto.find_by(id:id)		        	  
	        	   if @photolist.nil?		        	  	
				 	   	 	   render :json =>{success: false, message:"Photo doesn't exists",data: {} },status => 400
				 	   	 else 
				 	   	 	   parameters = ActionController::Parameters.new(params)
				 	   	 	   permitted_parameters = parameters.permit(:name,:description)
				 	   	 	   @photolist.update(permitted_parameters)
				 	   	 	   if @photolist.save!
				 	   	 	   	render :json =>{success:true ,message:"Photo update successfully",data: @photolist }, :status=>200
				 	   	 	   end 	
				       end
					  rescue
				  	  # Error Response
								render :json => { success: false, 
								message: e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors.full_messages[0] : e.message,
								data: {} }, :status => 400
								logger.error(e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors : e.message)
					  end 	
				end 	



end 	