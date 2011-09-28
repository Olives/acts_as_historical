class DependentModel < ActiveRecord::Base

  belongs_to :watched_model
  belongs_to :second_watched_model

  acts_as_historical_dependent([:watched_model, :second_watched_model],
                               :display => {:second_watched_model_id => :second_model_name,
                               :watched_model_id => :watched_model_name})

  def second_model_name
    second_watched_model.name
  end

  def watched_model_name
    watched_model.name
  end

end
