set :output, "log/cron.log"
env :PATH, "/home/lalitha/.rbenv/shims:/home/lalitha/.rbenv/bin:/usr/local/bin:/usr/bin:/bin"


<<<<<<< HEAD
every 1.day, at: '17:00 pm' do
  runner "Task.check_deadlines"
end

every 1.day, at: '17:01 pm' do
=======
every 1.day, at: '14:05 pm' do
  runner "Task.check_deadlines"
end

every 1.day, at: '14:10 pm' do
>>>>>>> e833fd3302f081aa03f0d785543041340fdc47a5
  runner "Task.send_deadline_reminders"
end
