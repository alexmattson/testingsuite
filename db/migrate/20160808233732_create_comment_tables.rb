class CreateCommentTables < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.integer :author_id, null: false
      t.integer :user_id, null: false
      t.text :body, null: false
      t.timestamps
    end

    add_index :user_comments, :author_id
    add_index :user_comments, :user_id

    create_table :goal_comments do |t|
      t.integer :author_id, null: false
      t.integer :goal_id, null: false
      t.text :body, null: false
      t.timestamps
    end

    add_index :goal_comments, :author_id
    add_index :goal_comments, :goal_id
  end
end
