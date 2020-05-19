class ProjectsController < ApplicationController
    def index
        @projects = Project.all
    end

    def new
        @project = Project.new
    end

    def create
        project = Project.new(project_params)
        project.owner_id = current_user.id

        if project.valid?
            project.save
            @project = project

            redirect_to project_path(project)
        else
            @project = project

            flash.now[:alert] = "Creation unsuccessful. Make sure that both fields are filled out and you aren't reusing project names"
            render :new
        end
    end

    def show
        @project = Project.find(params[:id])
    end

    private

    def project_params
        params.require(:project).permit(
          :name,
          :description
        )
    end
end
