class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :votedresponse_id

      t.timestamps
    end

    add_index :votes, :user_id
    add_index :votes, :votedresponse_id
    add_index :votes, [:user_id, :votedresponse_id], unique: true
  end
end
