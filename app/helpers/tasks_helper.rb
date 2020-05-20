module TasksHelper
    def check_task(project_id, id)
        if !Task.exists?(id)
            flash[:alert] = "Task not found."
            redirect_to project_path(project_id)
        else
            yield
        end
    end
end
