set :output, "log/cron.log"

every 1.day, at: '9:00 am' do
  runner "Task.check_deadlines"
end

every 1.day, at: '9:15 am' do
  runner "Task.send_deadline_reminders"
end
