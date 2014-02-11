class AddToSSub < ActiveRecord::Migration
  def up
  	add_column :subject_surveys , :question_id , :integer
  	add_column :subject_surveys , :answer_id , :integer
  	add_column :subject_surveys, :student_id, :integer
  end

  def down
  end
end
