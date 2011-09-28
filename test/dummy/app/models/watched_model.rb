class WatchedModel < ActiveRecord::Base

  has_many :dependent_models

  has_and_belongs_to_many :habtm_models, :before_add => :record_add_dependent, :before_remove => :record_remove_dependent

  acts_as_historical :track_association => :dependent_models

end
