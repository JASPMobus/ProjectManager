class ProjectsController < ApplicationController
    def index
    end

    def new
        @project = Project.new
    end

    def create
        project = Project.new(project_params)
        project.owner_id = current_user.id

        puts project.valid?

        if project.valid?
            project.save
            puts "#####################################"
            puts project.owner_id
            puts "#####################################"

            redirect_to project_path(project)
        else
            @project = project

            render :new
        end
    end

    def show
        @project = Project.find_by(params["id"])
    end

    private

    def project_params
        params.require(:project).permit(
          :name,
          :description
        )
    end
end
