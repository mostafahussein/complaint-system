class CreateQuestionnaires < ActiveRecord::Migration
  def change
    create_table :questionnaires do |t|
      t.integer :student_id
      t.integer :subject_id
      t.integer :survey_id
      t.integer :question_id
      t.integer :answer_id
      t.string :describtion
      t.string :comment
      t.timestamps
    end
  end
end
