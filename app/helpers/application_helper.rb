module ApplicationHelper
    def check_login
        if !current_user
            redirect_to sign_in_path
        end
    end
end
