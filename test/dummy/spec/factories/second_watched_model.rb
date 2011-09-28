FactoryGirl.define do
  factory :second_watched_model do
    sequence(:name) {|n| "Second Watched Model #{n}" }
    status "pending"
    sequence(:watcher) {|n| "Second Watcher #{n}"}
  end
end
