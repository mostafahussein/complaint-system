class Addrequiredquestion < ActiveRecord::Migration
  def up
  	add_column :questions, :required_question ,:boolean, default: true
  end

  def down
  end
end
