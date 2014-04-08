class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :section_name
      t.integer :batch_id
      t.timestamps
    end
  end
end
