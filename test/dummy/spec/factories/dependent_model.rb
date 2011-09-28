FactoryGirl.define do
  factory :dependent_model do
    status "active"
    watched_model
    second_watched_model
  end
end
