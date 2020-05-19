class Task < ApplicationRecord
    #Associations
    belongs_to :user
    belongs_to :project

    #Validations
    validates :summary, presence: true
    validates :summary, length: { maximum: 100 }
end
