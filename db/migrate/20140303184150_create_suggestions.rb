class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.integer :student_id
      t.integer :subject_id
      t.integer :subject_field_id
      t.string :content
      t.string :title

      t.timestamps
    end
  end
end
