class DependentModel < ActiveRecord::Base

  belongs_to :watched_model
  belongs_to :second_watched_model

end
