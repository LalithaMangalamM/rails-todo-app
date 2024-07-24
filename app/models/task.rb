class Task < ApplicationRecord
  belongs_to :user

  enum status: {pending: 0, completed: 1, missed: 2}

  validates :task_name, presence: true
  validates :dead_line, presence: true

  def self.check_deadlines
    # Find all tasks that have missed their deadline
    tasks = where("dead_line < ? AND status = ?", Time.current, statuses[:pending])
    
    # Group tasks by user
    tasks_by_user = tasks.group_by(&:user_id)
    
    tasks_by_user.each do |user_id, tasks|
      user = User.find(user_id)
      TaskMailer.deadline_missed(user, tasks).deliver_now
      tasks.each { |task| task.update(status: :missed) }
    end
  end

  def self.send_deadline_reminders
    current_time = Time.current
    reminder_start_time = current_time.beginning_of_day + 1.day
    reminder_end_time = current_time.end_of_day + 1.day

    # Find all tasks that are due tomorrow and have not had a reminder sent
    tasks = where(dead_line: reminder_start_time..reminder_end_time, status: :pending, reminder_sent: false)

    # Group tasks by user
    tasks_by_user = tasks.group_by(&:user_id)

    tasks_by_user.each do |user_id, tasks|
      user = User.find(user_id)
      TaskMailer.deadline_reminder(user, tasks).deliver_now
      tasks.update_all(reminder_sent: true)
    end
  end

  # Reset reminder_sent if deadline changes
  before_save :reset_reminder_sent, if: :dead_line_changed?

  private

  def reset_reminder_sent
    self.reminder_sent = false
  end

end
