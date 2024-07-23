set :output, "log/cron.log"
env :PATH, "/home/lalitha/.rbenv/shims:/home/lalitha/.rbenv/bin:/usr/local/bin:/usr/bin:/bin"


every 1.day, at: '14:05 pm' do
  runner "Task.check_deadlines"
end

every 1.day, at: '14:10 pm' do
  runner "Task.send_deadline_reminders"
end
