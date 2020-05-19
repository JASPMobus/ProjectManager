class Project < ApplicationRecord
    #Associations
    has_many :tasks
    has_many :users, through: :tasks

    #Validations
    #The project must have a name that the user hasn't already used for a different project.
    validates :name, presence: true
    validates :name, uniqueness: { scope: [:owner] }

    #Methods
    def owner
        User.find(owner_id)
    end
end
