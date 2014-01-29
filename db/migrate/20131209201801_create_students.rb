class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :full_name, limit: 30
      t.string :batch_name, limit: 30
      t.string :section_name, limit: 30
      t.string :gender, limit: 6
      t.integer :user_id


      t.timestamps
    end
  end
end
