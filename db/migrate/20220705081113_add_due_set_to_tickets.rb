class AddDueSetToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :due_set, :boolean, default: false
  end
end
