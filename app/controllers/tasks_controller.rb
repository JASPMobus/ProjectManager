class TasksController < ApplicationController
    include ApplicationHelper
    include ProjectsHelper
    include TasksHelper

    before_action :check_login
    before_action :check_project_before_action, except: [:destroy, :mine]

    #Shows all tasks for the selected project on a single page.
    def index
        @project = Project.find(project_id)
        @tasks = @project.tasks
    end

    #Shows all tasks for the logged in user on a single page, regardless of project.
    def mine
        @tasks_by_projects = Task.my_tasks_by_project(current_user)

        puts @tasks_by_projects

        render :mine
    end

    #Creation form for tasks.
    def new
        @task = Task.new
        @task.project_id = project_id
    end

    #Processing a form submission for new tasks.
    def create
        @task = Task.new(task_params)

        #tasks are nested under projects at creation, so there isn't a field necessary in the form. We manually put in the info.
        @task.project_id = project_id

        if @task.valid?
            @task.save

            redirect_to project_task_path(project_id, @task)
        else
            render :new
        end
    end

    #Editing form for tasks.
    def edit
        check_task(project_id, params[:id]) do
            @task = Task.find(params[:id])
        end
    end

    #Processing a form submission for edited tasks.
    def update
        @task = Task.find(params[:id])
        @task.update(task_params)

        if @task.valid?
            @task.save

            redirect_to project_task_path(project_id, @task)
        else
            render :new
        end
    end

    #Showing the page that represents a single task.
    def show
        check_task(project_id, params[:id]) do
            @task = Task.find(params[:id])
        end
    end

    #Destroying the task represented by the given ID.
    def destroy
        @task = Task.find(params[:id])
        puts @task
        @project = @task.project
        
        #destroy the task
        @task.destroy

        #Provide visual confirmation of deletion and redirect to task index page
        flash[:notice] = "Task deleted."

        redirect_to project_path(@project.id)
    end 

    private

    #This is used enough that I figured I might as well have it defined here.
    def project_id
        params[:project_id]
    end

    #The params given from the form.
    def task_params
        params.require(:task).permit(
          :summary,
          :description,
          :user_id
        )
    end

    #A yield block can't be in a before_action. This is the workaround that I came up with.
    def check_project_before_action
        check_project(project_id) do
        end
    end
end
