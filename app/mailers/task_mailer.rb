class TaskMailer < ApplicationMailer
  default from: 'tablefit.2023@gmail.com'

  def deadline_missed(task)
    @task = task
    @user = @task.user
    @task_url = task_url(@task)
    mail(to: @user.email, subject: 'Task Deadline Missed')
  end

  def deadline_reminder(task)
    @task = task
    @user = @task.user
    @task_url = task_url(@task)
    mail(to: @user.email, subject: 'Task Deadline Reminder')
  end

  private

  def task_url(task)
    Rails.application.routes.url_helpers.task_url(task, host: 'localhost', port: 3000) # have to change host and port for production
  end
end
