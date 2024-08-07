class Task < ApplicationRecord
  belongs_to :user

  enum status: { pending: 0, completed: 1, missed: 2 }

  validates :task_name, presence: true
  validates :dead_line, presence: true

  def self.check_deadlines
<<<<<<< HEAD
    today_start = Time.current.beginning_of_day + 1.day
    today_end = Time.current.end_of_day + 1.day

    tasks = Task.where("dead_line BETWEEN ? AND ? AND status = ? AND deadline_mail_sent = ?", 
                       today_start, 
                       today_end, 
                       Task.statuses[:pending], false)

    if tasks.any?
      tasks.group_by(&:user).each do |user, tasks|
        TaskMailer.deadline_missed(tasks: tasks).deliver_now
        tasks.each { |task| task.update(reminder_sent: true) }
      end
    else
      puts "No tasks needing reminders."
=======
    # Find all tasks that have missed their deadline
    tasks = where("dead_line < ? AND status = ?", Time.current, statuses[:pending])
    
    # Group tasks by user
    tasks_by_user = tasks.group_by(&:user_id)
    
    tasks_by_user.each do |user_id, tasks|
      user = User.find(user_id)
      TaskMailer.deadline_missed(user, tasks).deliver_now
      tasks.each { |task| task.update(status: :missed) }
>>>>>>> e833fd3302f081aa03f0d785543041340fdc47a5
    end
  end

  def self.send_deadline_reminders
<<<<<<< HEAD
    tasks = where("dead_line BETWEEN ? AND ? AND status = ? AND reminder_sent = ?", Time.current.beginning_of_day, Time.current.end_of_day, statuses[:pending], false)
     Rails.logger.debug "Found #{tasks.count} tasks needing reminders"

    tasks_by_user = tasks.group_by(&:user_id)
    Rails.logger.debug "Preparing to send reminder to for #{tasks.count} tasks"

  
    tasks_by_user.each do |user_id, tasks|
      user = User.find(user_id)
      tasks.each do |task|
        TaskMailer.deadline_reminder(user, task).deliver_now
        # Rails.logger.debug "Reminder sent to #{user.email}"
        task.update(reminder_sent: true)
      end
    end
  end
  

  # Reset reminder_sent and deadline_mail_sent if deadline changes
  before_save :reset_mail_sent_flags, if: :dead_line_changed?
=======
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
>>>>>>> e833fd3302f081aa03f0d785543041340fdc47a5

  private

  def reset_mail_sent_flags
    self.reminder_sent = false
    self.deadline_mail_sent = false
  end
end

def self.check_deadlines
  tasks = where("dead_line < ? AND status = ?", Time.current, statuses[:pending])
  
  tasks_by_user = tasks.group_by(&:user_id)
  
  tasks_by_user.each do |user_id, tasks|
    user = User.find(user_id)
    TaskMailer.deadline_missed(user, tasks).deliver_now
    tasks.each { |task| task.update(status: :missed) }
  end
end