class CreateEmployeePositions < ActiveRecord::Migration
  def change
    create_table :employee_positions do |t|
      t.string :position_title, limit: 30

      t.timestamps
    end
  end
end
