class AddAffiliationToMiniposts < ActiveRecord::Migration
  def change
    add_column :miniposts, :affiliation_id, :integer
  end
end
