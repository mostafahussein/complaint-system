class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :canned_response

      t.timestamps
    end
  end
end
