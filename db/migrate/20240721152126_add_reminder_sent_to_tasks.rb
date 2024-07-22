class AddReminderSentToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :reminder_sent, :boolean, default: false
  end
end
