class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.boolean :private, null: false, default: false
      t.boolean :completed, null: false, default: false
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :details, null: false
      t.timestamps null: false
    end

    add_index :goals, :user_id
  end
end
