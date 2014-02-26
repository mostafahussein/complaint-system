class AddCategoriesToFaq < ActiveRecord::Migration
  def change
  	remove_column :kbs , :category
  	add_column :kbs , :subject_id , :integer
  end
end
