class Project < ApplicationRecord
    after_save :add_creator_as_editor

    belongs_to :user
    has_and_belongs_to_many :editors, class_name: 'User'

    private

    def add_creator_as_editor
        project = Project.last
        project.editors.append(project.user)
    end
end
