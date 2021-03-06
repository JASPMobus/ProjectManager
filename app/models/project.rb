class Project < ApplicationRecord
    #Associations
    has_many :tasks
    has_many :users, through: :tasks

    #Validations
    #The project must have a name that the user hasn't already used for a different project.
    validates :name, presence: true
    validates :name, uniqueness: { scope: :owner_id }

    #Methods
    def owner
        User.find(self.owner_id)
    end

    def self.owned_by(owner_id)
        Project.where(owner_id: owner_id)
    end

    def self.exists?(id)
        !!Project.find_by(id: id)
    end
end
