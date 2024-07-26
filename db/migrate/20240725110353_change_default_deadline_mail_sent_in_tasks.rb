class ChangeDefaultDeadlineMailSentInTasks < ActiveRecord::Migration[7.1]
  def change
    change_column_default :tasks, :deadline_mail_sent, from: nil, to: false
  end
end
