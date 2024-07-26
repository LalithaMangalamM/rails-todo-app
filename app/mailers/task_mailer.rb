
class TaskMailer < ApplicationMailer
  default from: 'tablefit.2023@gmail.com'

  def deadline_missed(tasks)
    @user = @task.user
    @tasks = tasks
    @task_urls = @tasks.map { |task| task_url(task) }
    mail(to: @user.email, subject: 'Tasks Deadline Missed')
  end

  def deadline_reminder(user, tasks)
    @user = user
    @tasks = tasks
    @task_urls = @tasks.map { |task| task_url(task) }
    mail(to: @user.email, subject: 'Tasks Deadline Reminder')
  end

  private

  def task_url(task)
<<<<<<< HEAD
    Rails.application.routes.url_helpers.task_url(task, host: 'localhost', port: 3000) # Update host and port for production
=======
    Rails.application.routes.url_helpers.task_url(task, host: 'localhost', port: 3000) # have to change host and port for production
>>>>>>> e833fd3302f081aa03f0d785543041340fdc47a5
  end
end
