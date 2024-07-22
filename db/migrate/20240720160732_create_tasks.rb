class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.serial :task_id
      t.string :task_name
      t.string :description
      t.datetime :dead_line
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
