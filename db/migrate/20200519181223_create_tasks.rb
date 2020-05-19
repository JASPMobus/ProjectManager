class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :summary
      t.text :description
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
  end
end
