class AddTotalToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :total, :integer, :default => 1
  end

  def self.down
    remove_column :votes, :total
  end
end
