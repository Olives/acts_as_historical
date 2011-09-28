class DependentModel < ActiveRecord::Base

  belongs_to :watched_model
  belongs_to :second_watched_model

  acts_as_historical_dependent([:watched_model, :second_watched_model])

end
