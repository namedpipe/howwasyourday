class AddSendDailyReminderToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :send_daily_reminder, :boolean, :default => 1
    User.update_all 'send_daily_reminder = 1'
  end

  def self.down
    remove_column :users, :send_daily_reminder
  end
end
