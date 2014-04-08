class CreateSubjectSurveys < ActiveRecord::Migration
  def change
    create_table :subject_surveys do |t|
      t.integer :survey_id
      t.integer :subject_id
      t.integer :question_id
      t.integer :answer_id
  	  t.integer :student_id
      t.text :free_answer
      t.timestamps
    end
  end
end
