FactoryGirl.define do
  factory :event do
    name "Ine kafe koncert"
    date Time.now+2.weeks
    type_id 2
    address "Trencin"
  end
end
