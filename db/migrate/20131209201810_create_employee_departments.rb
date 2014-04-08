class CreateEmployeeDepartments < ActiveRecord::Migration
  def change
    create_table :employee_departments do |t|
      t.string :department_name, limit: 30

      t.timestamps
    end
  end
end
