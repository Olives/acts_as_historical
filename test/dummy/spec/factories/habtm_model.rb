FactoryGirl.define do
  factory :habtm_model do
    sequence(:code) {|n| "#{n}" }
  end
end
