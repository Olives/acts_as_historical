class HistoryTableCreation < ActiveRecord::Migration

  def up
    create_table :histories do |t|
      t.integer :editor_id
      t.datetime :created_at
      t.string :historical_type
      t.integer :historical_id
      t.text :before
      t.text :after
      t.string :item_type
    end
  end

  def down
    drop_table :histories
  end

end
