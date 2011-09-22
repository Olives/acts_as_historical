class SecondWatchedModel < ActiveRecord::Base

  has_many :dependent_models

  save_history


end
