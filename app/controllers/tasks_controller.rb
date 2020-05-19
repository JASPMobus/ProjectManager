class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)
        @task.project_id = params[:project_id]

        if @task.valid?
            @task.save

            redirect_to task_path(task)
        else
            render :new
        end
    end

    def show
        @task = Task.find(params[:id])
    end

    private

    def task_params
        params.require(:task).permit(
          :name,
          :description
        )
    end
end
