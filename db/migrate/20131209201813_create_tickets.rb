class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title, limit: 100
      t.text :description
      t.integer :student_id
      t.integer :subject_id
      t.integer :priority_id

      t.timestamps
    end
  end
end
