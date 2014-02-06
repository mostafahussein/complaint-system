class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :full_name, limit: 30
      t.string :gender, limit: 6
      t.integer :user_id
      t.integer :batch_id
      t.integer :section_id


      t.timestamps
    end
  end
end
