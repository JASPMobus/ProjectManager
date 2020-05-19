class ProjectsController < ApplicationController
    def index
    end

    def new
        @project = Project.new
    end

    def create
        project = Project.new(project_params)

        if project.valid?
            project.save

            redirect_to project_path(project)
        else
            render :new
        end
    end

    private

    def project_params
        params.require(:project).permit(
          :name,
          :description
          ]
        )
    end
end
