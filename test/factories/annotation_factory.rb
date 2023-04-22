FactoryBot.define do
  factory :annotation do
    book

    highlighted_text { Faker::Lorem.paragraph }
    notes { }
    timestamp { Faker::Time.backward }

    trait :with_notes do
      notes { Faker::Lorem.sentence }
    end

    trait :without_highlight do
      highlighted_text { }
    end

    # start_cfi { }
    # end_cfi { }
    
  end
end
