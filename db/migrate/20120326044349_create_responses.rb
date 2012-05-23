class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :content
      t.integer :minipost_id
      t.integer :user_id

      t.timestamps
    end
    add_index :responses, [:minipost_id, :created_at]
    add_index :responses, [:user_id, :created_at]
  end
end
