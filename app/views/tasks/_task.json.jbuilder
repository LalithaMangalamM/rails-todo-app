json.extract! task, :id, :task_id, :task_name, :description, :dead_line, :user_id, :created_at, :updated_at
json.url task_url(task, format: :json)
