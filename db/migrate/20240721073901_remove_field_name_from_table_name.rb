class RemoveFieldNameFromTableName < ActiveRecord::Migration[7.1]
  def change
    remove_column :tasks, :task_id, :integer
  end
end
