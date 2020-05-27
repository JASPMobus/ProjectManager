module UsersHelper
    def check_user(id)
        if !User.exists?(id)
            flash[:alert] = "User not found."
            redirect_to projects_path
        else
            yield
        end
    end
end
