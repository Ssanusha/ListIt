class AddShareIdToShares < ActiveRecord::Migration
  def change
    add_column :shares, :share_id, :integer
  end
end
