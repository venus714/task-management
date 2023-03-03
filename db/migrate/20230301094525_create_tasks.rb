class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.datetime :due
      t.integer :user_id
      t.datetime :createdAt, null:false
      t.integer :status, null: false, default: 0

    end

  end
end
