FactoryBot.define do
  factory :flashcard do
    annotation { nil }
    next_repetition_date { "2023-04-29" }
    interval { 1 }
    easiness_factor { 1.5 }
  end
end
