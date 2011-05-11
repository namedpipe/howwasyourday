class AddCommentsToStatus < ActiveRecord::Migration
  def self.up
		add_column :statuses, :comments, :string
  end

  def self.down
		remove_column :statuses, :comments
  end
end