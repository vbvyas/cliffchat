class CreateMiniposts < ActiveRecord::Migration
  def change
    create_table :miniposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :miniposts, [:user_id, :created_at]
  end
end
