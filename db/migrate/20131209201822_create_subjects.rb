class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :subject_title
      t.string :subject_code, limit: 10
      t.integer :survey_id

      t.timestamps
    end
    add_index :subjects, :subject_title
  end
end
