class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :ticket_status, limit: 15

      t.timestamps
    end
  end
end
