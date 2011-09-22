class HistoryTable < ActiveRecord::Migration

  def up
    create_table :action_histories do |t|
      t.integer :history_editor_id
      t.string :history_editor_type
      t.datetime :created_at
      t.string :history_recordable_type
      t.integer :history_recordable_id
      t.string :history_dependable_type
      t.integer :history_dependable_id
      t.text :changed_fields
    end
  end

  def down
    drop_table :action_histories
  end

end
