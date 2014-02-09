class CreateSubjectSurveys < ActiveRecord::Migration
  def change
    create_table :subject_surveys do |t|
      t.integer :survey_id
      t.integer :subject_id
      t.timestamps
    end
  end
end
