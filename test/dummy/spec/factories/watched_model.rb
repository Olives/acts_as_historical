FactoryGirl.define do
  factory :watched_model do
    sequence(:name) {|n| "Watched Model #{n}" }
    status "pending"
    sequence(:watcher) {|n| "Watcher #{n}" }
  end
end
