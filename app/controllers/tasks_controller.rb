class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end

    def new
        @task = Task.new
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
        @task = Task.find(params[:id])
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
        @task = Task.find(params[:id])
    end

    def destroy
        @task = Task.find(params[:id])
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
end
