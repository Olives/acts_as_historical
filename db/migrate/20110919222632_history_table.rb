class HistoryTable < ActiveRecord::Migration

  def up
    create_table :action_histories do |t|
      t.integer :editor_id
      t.datetime :created_at
      t.string :recordable_type
      t.integer :recordable_id
      t.text :changed_fields
    end
  end

  def down
    drop_table :action_histories
  end

end
