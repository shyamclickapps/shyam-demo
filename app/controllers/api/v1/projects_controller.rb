class Api::V1::ProjectsController < Api::V1::BaseController

  def index
    @projects  = Project.all
    render :json => { success: true, message: "success",
                      data: ActiveModel::ArraySerializer.new(@projects, each_serializer: ProjectSerializer)}
  end
  def create

  end




end
