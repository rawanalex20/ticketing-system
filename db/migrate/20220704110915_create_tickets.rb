class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :title
      t.string :description
      t.string :status
      t.belongs_to :project

      t.timestamps
    end
  end
end
