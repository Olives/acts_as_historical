class HasManyModelsTables < ActiveRecord::Migration

  def up
    create_table :habtm_models do |t|
      t.string :code
    end
    create_table :habtm_models_watched_models, :id => false do |t|
      t.integer :habtm_model_id
      t.integer :watched_model_id
    end
  end

  def down
    drop_table :habtm_models
    drop_table :habtm_models_watched_models
  end
end
