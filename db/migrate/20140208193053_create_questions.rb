class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :survey_id
      t.string :content
      t.string :question_type
      t.string :help_text
      t.boolean :required_question, default: true
      t.timestamps
    end
  end
end
