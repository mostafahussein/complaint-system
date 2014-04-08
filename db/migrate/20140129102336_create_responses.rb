class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
      t.string :canned_response
      t.timestamps
    end
  end
end
