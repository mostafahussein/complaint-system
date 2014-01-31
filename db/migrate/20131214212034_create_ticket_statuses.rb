class CreateTicketStatuses < ActiveRecord::Migration
  def change
    create_table :ticket_statuses do |t|
      t.integer :status_id
      t.integer :ticket_id
      t.integer :staff_id
      t.integer :advisor_id

      t.timestamps
    end
  end
end
