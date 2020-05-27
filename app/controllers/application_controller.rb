class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :authenticate_user!

    protected

    #Add name to the fields that are taken for users.
    def configure_permitted_parameters
        devise.parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
