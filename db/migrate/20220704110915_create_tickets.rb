class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :status
      t.belongs_to :project

      t.timestamps
    end
  end
end
