class CreateKbs < ActiveRecord::Migration
  def change
    create_table :kbs do |t|
      t.string :faq_question
      t.string :faq_answer
      t.integer :subject_id

      t.timestamps
    end
  end
end
