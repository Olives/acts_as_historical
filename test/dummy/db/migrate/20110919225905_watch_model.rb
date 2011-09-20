class WatchModel < ActiveRecord::Migration

  def up
    create_table :watched_models do |t|
      t.string :name
    end
  end

  def down
    drop_table :watched_models
  end
end
