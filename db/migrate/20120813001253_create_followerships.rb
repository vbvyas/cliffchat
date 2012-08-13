class CreateFollowerships < ActiveRecord::Migration
  def change
    create_table :followerships do |t|
      t.integer :user_id
      t.integer :topic_id

      t.timestamps
    end

    add_index :followerships, :user_id
    add_index :followerships, :topic_id
    add_index :followerships, [:user_id, :topic_id], unique: true
  end
end
