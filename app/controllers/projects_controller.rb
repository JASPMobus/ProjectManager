class ProjectsController < ApplicationController
    def index
        @projects = Project.all
    end

    def new
        @project = Project.new
    end

    def create
        @project = Project.new(project_params)
        @project.owner_id = current_user.id

        if @project.valid?
            @project.save

            redirect_to project_path(@project)
        else
            render :new
        end
    end

    def show
        @project = Project.find(params[:id])
    end

    def destroy
        @project = Project.find(params[:id])
        
        #destroy all connected tasks
        @project.tasks.each do |task|
            task.destroy
        end
        
        #destroy the project
        @project.destroy

        #Provide visual confirmation of deletion and redirect to project index page
        flash[:notice] = "Project deleted."

        redirect_to projects_path
    end 

    private

    def project_params
        params.require(:project).permit(
          :name,
          :description
        )
    end
end
