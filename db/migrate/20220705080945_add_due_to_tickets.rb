class AddDueToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :due, :datetime
  end
end
