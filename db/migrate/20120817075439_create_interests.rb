class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.integer :user_id
      t.integer :followedpost_id

      t.timestamps
    end

    add_index :interests, :user_id
    add_index :interests, :followedpost_id
    add_index :interests, [:user_id, :followedpost_id], unique: true
  end
end
