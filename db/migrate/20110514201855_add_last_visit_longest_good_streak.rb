class AddLastVisitLongestGoodStreak < ActiveRecord::Migration
  def self.up
		add_column :users, :last_visit, :datetime
		add_column :users, :longest_good_streak, :integer
  end

  def self.down
		remove_column :users, :longest_good_streak
		remove_column :users, :last_visit
  end
end