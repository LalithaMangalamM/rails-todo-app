class AddDeadlineMailSentToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :deadline_mail_sent, :boolean
  end
end
