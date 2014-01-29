class CreateFollowUps < ActiveRecord::Migration
  def change
    create_table :follow_ups do |t|
      t.string :text, limit: 140
      t.integer :ticket_id
      t.integer :user_id
      t.integer :priority_id

      t.timestamps
    end
  end
end
