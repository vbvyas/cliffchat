class CreateMinipostsTopicsJoinTables < ActiveRecord::Migration
  def change
    create_table :miniposts_topics, :id => false do |t|
      t.integer :minipost_id
      t.integer :topic_id

      t.timestamps
    end

    add_index :miniposts_topics, :minipost_id
    add_index :miniposts_topics, :topic_id
    add_index :miniposts_topics, [:minipost_id, :topic_id], unique: true
  end
end
