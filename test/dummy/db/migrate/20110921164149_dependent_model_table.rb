class DependentModelTable < ActiveRecord::Migration

  def up
    create_table :dependent_models do |t|
      t.string :name
      t.integer :watched_model_id
    end
  end

  def down
    drop_table :dependent_models
  end
end
