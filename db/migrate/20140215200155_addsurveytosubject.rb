class Addsurveytosubject < ActiveRecord::Migration
  def up
  	add_column :subjects, :survey_id , :integer
  end

  def down
  end
end
