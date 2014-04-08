class CreateSubjectFields < ActiveRecord::Migration
  def change
    create_table :subject_fields do |t|
      t.string :field_name

      t.timestamps
    end
  end
end
