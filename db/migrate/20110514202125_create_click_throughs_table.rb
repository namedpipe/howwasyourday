class CreateClickThroughsTable < ActiveRecord::Migration
  def self.up
		create_table :rating_links, :force => true do |t|
		  t.string :link_hash
		  t.integer :user_id
		  t.date :for_date
		  t.string :rating
		  t.boolean :used, :default => 0
		  t.timestamps
		end
  end

  def self.down
		drop_table :click_through
  end
end