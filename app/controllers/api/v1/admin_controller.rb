class Api::V1::AdminController < Api::V1::BaseController
  before_action :authenticate
  # get /v1/admindashboard/
  def index
    begin
      @userlist = User.where('user_type NOT IN (?)', 10)
      render :json => { success: true, message: "success", data:ActiveModel::ArraySerializer.new(@userlist, each_serializer: UserlistSerializer)}, :status => 201

    rescue
      # Error Response
      render :json => { success: false,
                        message: e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors.full_messages[0] : e.message,
                        data: {} }, :status => 400
      logger.error(e.is_a?(ActiveRecord::RecordInvalid) ? e.record.errors : e.message)
    end
  end
end
