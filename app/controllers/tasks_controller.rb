class TasksController < ApplicationController
    include ProjectsHelper
    include TasksHelper

    before_action :check_project_before_action, except: :destroy

    def index
        @project = Project.find(project_id)
        @tasks = @project.tasks
    end

    def new
        @task = Task.new
        @task.project_id = project_id
    end

    def create
        @task = Task.new(task_params)
        @task.project_id = project_id

        if @task.valid?
            @task.save

            redirect_to project_task_path(project_id, @task)
        else
            render :new
        end
    end

    def edit
        check_task(project_id, params[:id]) do
            @task = Task.find(params[:id])
        end
    end

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

    def show
        check_task(project_id, params[:id]) do
            @task = Task.find(params[:id])
        end
    end

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

    def project_id
        params[:project_id]
    end

    def task_params
        params.require(:task).permit(
          :summary,
          :description,
          :user_id
        )
    end

    def check_project_before_action
        check_project(project_id) do
        end
    end
end
