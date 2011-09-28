class WatchedModel < ActiveRecord::Base

  has_many :dependent_models

  acts_as_historical :track_association => :dependent_models

end
