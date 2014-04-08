class CreateSubjectStaffs < ActiveRecord::Migration
  def change
    create_table :subject_staffs do |t|
      t.integer :staff_id
      t.integer :advisor_id
      t.integer :subject_id
      t.timestamps
    end
  end
end
