class Ticket < ApplicationRecord
    belongs_to :project

    validates :title, presence: true
    validates :description, presence: true
    validates :status, inclusion: { in: %w(ToDo InProgress Done), message: "%{value} is not valid" }

end
