class AdditionFieldsForTables < ActiveRecord::Migration

  def up
    change_table :watched_models do |t|
      t.string :status
      t.string :watcher
    end
    change_table :second_watched_models do |t|
      t.string :status
      t.string :watcher
    end
    change_table :dependent_models do |t|
      t.integer :second_watched_model_id
      t.string :status
    end
  end

  def down
    change_table :watched_models do |t|
      t.remove :status
      t.remove :watcher
    end
    change_table :second_watched_models do |t|
      t.remove :status
      t.remove :watcher
    end
    change_table :dependent_models do |t|
      t.remove :second_watched_model_id
      t.remove :status
    end
  end

end
