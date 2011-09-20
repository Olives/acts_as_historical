class SecondWatchedModelTable < ActiveRecord::Migration

  def up
    create_table :second_watched_models do |t|
      t.string :name
    end
  end

  def down
    drop_table :second_watched_models
  end
end
