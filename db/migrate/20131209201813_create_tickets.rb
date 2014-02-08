class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.text :description
      t.integer :student_id
      t.integer :subject_id
      t.integer :priority_id
      t.date :due
      t.integer :category_id
      t.date :date_of_alleged_event
      t.text :reason_of_delay
      t.text :expectations

      t.timestamps
    end
  end
end
