class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :project_name, null: false
      t.belongs_to :user

      t.timestamps
    end
  end
end
