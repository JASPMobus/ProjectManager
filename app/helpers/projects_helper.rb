module ProjectsHelper
    def check_project(id)
        if !Project.exists?(id)
            flash[:alert] = "Project not found."
            redirect_to projects_path
        else
            yield
        end
    end
end
