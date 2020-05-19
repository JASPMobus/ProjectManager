class Project < ApplicationRecord
    #Associations
    belongs_to :user
    has_many :tasks
    has_many :users, through: :tasks
end
