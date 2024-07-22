class Task < ApplicationRecord
  belongs_to :user

  enum status: {pending: 0, completed: 1, missed: 2}

  validates :task_name, presence: true
  validates :dead_line, presence: true

  def self.check_deadlines
      where("dead_line < ? AND status = ?", Time.current, statuses[:pending]).find_each do | task |
      task.update(status: :missed)
      TaskMailer.deadline_missed(task).deliver_now
      end
  end

  def self.send_deadline_reminders
    current_time = Time.current
    reminder_start_time = current_time.beginning_of_day + 1.day
    reminder_end_time = current_time.end_of_day + 1.day
    tasks = Task.where(dead_line: reminder_start_time..reminder_end_time, status: 0, reminder_sent: false)

    tasks.find_each do | task |
      TaskMailer.deadline_reminder(task).deliver_now
      task.update(reminder_sent: true)
    end
  end
  before_save :reset_reminder_sent, if: :dead_line_changed?

  private

  def reset_reminder_sent
    self.reminder_sent = false
  end

end
