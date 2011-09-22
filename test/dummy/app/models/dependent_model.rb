class DependentModel < ActiveRecord::Base

  belongs_to :watched_model
  belongs_to :second_watched_model

  save_history store_on: [:watched_model, :second_watched_model], only: [:status]

end
