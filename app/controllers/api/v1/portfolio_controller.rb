class Api::V1::PortfolioController < Api::V1::BaseController
     
      before_action :authenticate, except: [:addproject,:index]
      
      ############fetch all project ###############
      def index
         begin
           if params[:user_id].present?
                @portfolio = Portfolio.where("user_id = '#{params[:user_id]}'")
           else 
                @portfolio = Portfolio.all
           
           end 
           if @portfolio.present?
             	  	 render :json => { success: true, message: "project List", data:ActiveModel::ArraySerializer.new(@portfolio, each_serializer: PortfolioSerializer)}, :status => 200 
           else
                   render :json => { success: true, message: "No project", data:[] }, :status => 200 
           end  
         rescue
    	       # Error Response
              render :json => { success: false, 
                          message: e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors.full_messages[0] : e.message,
                          data: {} }, :status => 400
				      logger.error(e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors : e.message)
         end 
      end  
          # api   :POST, 'v1/portfolio/addproject', "Create new Portfolio"
          # param :name, String, :desc => "Project Name", :required => true
          # param :desc, String, :desc => "Project Description", :required => true
          # param :area, String, :desc => "Project Area", :required => true
          # param :avatar, ActionDispatch::Http::UploadedFile, :desc => "Portfolio photo", :required => false
          # param :userid, String, :desc => "Current User ID", :required => true
          # param :startdate, String, :desc => "Start date", :required => true
          # param :enddate, String, :desc => "End date", :required => true
          # param :token,String, :desc=>"authenticationtoken",:required =>true	    	
      def addproject
              # skip_before_action :authenticate
		      	  begin
                
	       	        portname = $FullSanitizer.sanitize(params[:name]).downcase
  		  	        #check the project name exists or name
                  @checkprojectexists = Portfolio.where("name = '#{portname}'")
                  if @checkprojectexists.present?
                   	 render :json => { success: false, message: "project name already exists" }, :status => 401 
                  else
                 # Strong Parameters
     						    parameters = ActionController::Parameters.new(:name => portname,
						  	              :description => params[:desc],
						  	              :projectarea =>params[:area], 
						  	              :avatar => params[:avatar], 
						  	              :user_id => params[:userid],
						  	              :start_date=>params[:startdate],
		  			  	              :end_date=>params[:enddate])
					        permitted_parameters = parameters.permit(:name,:description,:avatar,:projectarea, :user_id,:start_date,:end_date)					     
                  @portfolio = Portfolio.new(permitted_parameters)
							      if @portfolio.save!
							        render :json => { success: true, message: "success", data:@portfolio }, :status => 201 
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

      def deleteproject
      
              begin
                  @id = params[:id]

                  if @id.present?
                    @delete = Portfolio.destroy(@id)
                      render :json => { success:true, message:"success", data: @delete } ,:status => 201
                  end   
              rescue
                   # Error Response
                  render :json => { success: false, 
                                    message: e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors.full_messages[0] : e.message,
                                    data: {} }, :status => 400
                  logger.error(e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors : e.message)
              end  
      end
      def expireproject
          begin

              date = Time.now
              
          rescue
              # Error Response
                  render :json => { success: false, 
                                    message: e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors.full_messages[0] : e.message,
                                    data: {} }, :status => 400
                  logger.error(e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors : e.message)
          end   
      end 
      def editproject
          begin
                   @portfolio = Portfolio.find(params[:id])
                   if @portfolio.present?
                    
                      render :json => { success:true, message:"success", data:@portfolio } ,:status => 201
                   end  
                   
                    
          rescue Exception => e 
               
                  # Error Response
                  render :json => { success: false, 
                                    message: e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors.full_messages[0] : e.message,
                                    data: {} }, :status => 400
                  logger.error(e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors : e.message)
          end 
      end

      def updateproject
          begin

            debugger
                   
          rescue Exception => e
                   
          end       
 
      end   

   




end 	