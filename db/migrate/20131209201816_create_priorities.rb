class CreatePriorities < ActiveRecord::Migration
  def change
    create_table :priorities do |t|
      t.string :priority_name, limit: 15
      t.string :color, limit: 10
      t.string :background, limit: 10

      t.timestamps
    end
  end
end
