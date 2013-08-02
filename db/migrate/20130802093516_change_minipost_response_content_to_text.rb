class ChangeMinipostResponseContentToText < ActiveRecord::Migration
  def change
    change_column :miniposts, :content, :text, :limit => nil
    change_column :responses, :content, :text, :limit => nil
  end
end
