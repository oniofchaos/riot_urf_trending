FactoryGirl.define do
  factory :champion do
    sequence(:riot_id)
    sequence(:name)           { |n| "Champion #{n}" }
    sequence(:primary_role)   { |n| "Role #{n}" }
    sequence(:secondary_role) { |n| "Role #{n}" }

    factory :champion_with_raw_api_data do
      transient do
        raw_api_data {}.to_json
      end

      after(:create) do |champion, evaluator|
        create(:champion_api_data,
               champion: champion,
               raw_api_data: evaluator.raw_api_data)
      end
    end

    factory :champion_with_champion_matches do
      transient do
        count 10
      end

      after(:create) do |champion, evaluator|
        create_list(:champion_match, evaluator.count, champion: champion)
      end
    end
  end
end
