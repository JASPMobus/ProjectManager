class Task < ApplicationRecord
    #Associations
    belongs_to :user
    belongs_to :project

    #Validations
    validates :summary, presence: true
    validates :summary, length: { maximum: 100 }

    def self.my_tasks_by_project(user_id)
        #collect all tasks assigned to the user
        tasks = Task.where("user_id = #{user_id}")

        projects = User.find(user_id).projects

        tasks_by_project = {}

        projects.each do |project|
            project_tasks = tasks.filter { |t| t.project = project }

            tasks_by_project[project] = project_tasks
        end

        return tasks_by_project
    end
end
