class ProjectsController < ApplicationController
    include ApplicationHelper
    include ProjectsHelper
    include UsersHelper
    
    before_action :check_login
    
    #Shows all projects on a single page.
    def index
        search = params[:search] 

        if search
            @projects = Project.all.filter { |p| p.name.include?(search)}
        else
            @project = Project.all
        end
    end

    #Shows all projects created by the user represented by the given owner_id on a single page.
    def started_by
        owner_id = params[:owner_id]

        check_user(owner_id) do
            @projects = Project.owned_by(owner_id)
            flash[:alert] = "Projects started by #{User.find(owner_id).name}:"

            render :index
        end
    end

    #Creation form for projects.
    def new
        @project = Project.new
    end

    #Processing a form submission for new projects.
    def create
        @project = Project.new(project_params)

        #The creator is the currently logged in user.
        @project.owner_id = current_user.id

        if @project.valid?
            @project.save

            redirect_to project_path(@project)
        else
            render :new
        end
    end

    #Showing the page that represents a single project.
    def show
        check_project(params[:id]) do 
            @project = project
        end
    end

    #Editing form for projects.
    def edit
        check_project(params[:id]) do
            @project = project
        end 
    end

    #Processing a form submission for edited projects.
    def update
        @project = project
        @project.update(project_params)

        if @project.valid?
            @project.save

            redirect_to project_path(@project)
        else
            render :edit
        end
    end

    #Destroying the project represented by the given ID.
    def destroy
        @project = project
        
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

    #The params given from the form.
    def project_params
        params.require(:project).permit(
          :name,
          :description
        )
    end

    def project
        Project.find(params[:id])
    end
end
