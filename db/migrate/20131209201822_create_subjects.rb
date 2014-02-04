class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :subject_title, limit: 30
      t.string :subjectCode, limit: 10

      t.timestamps
    end
  end
end
