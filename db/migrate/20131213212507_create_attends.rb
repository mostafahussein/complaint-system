class CreateAttends < ActiveRecord::Migration
  def change
    create_table :attends do |t|
      t.integer :student_id
      t.integer :subject_id
      t.timestamps
    end
  end
end
