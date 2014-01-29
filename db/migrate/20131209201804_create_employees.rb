class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :full_name, limit: 30
      t.string :gender, limit: 6
      t.string :type, limit: 15
      t.integer :user_id
      t.integer :employee_department_id
      t.integer :employee_position_id

      t.timestamps
    end
  end
end
