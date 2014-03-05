class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string :text
      t.integer :suggestion_id
      t.integer :user_id

      t.timestamps
    end
  end
end
