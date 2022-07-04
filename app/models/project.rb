class Project < ApplicationRecord
    belongs_to :creator, class_name: 'User'
    has_and_belongs_to_many :editors, class_name: 'User'
    
end
