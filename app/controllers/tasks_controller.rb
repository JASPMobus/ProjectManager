class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end

    def new
        @task = Task.new
        @project = Project.find(project_id)
    end

    def create
        @task = Task.new(task_params)
        @task.project_id = project_id

        if @task.valid?
            @task.save

            redirect_to project_task_path(project_id, @task)
        else
            @project = Project.find(project_id)

            render :new
        end
    end

    def show
        @task = Task.find(params[:id])
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
end
