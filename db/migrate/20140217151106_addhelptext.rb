class Addhelptext < ActiveRecord::Migration
  def up
  	remove_column :surveys , :help_text
  	add_column :questions , :help_text , :string
  end

  def down
  end
end
