FactoryBot.define do
  factory :card do
    advancement_requirement { nil }
    agenda_points { nil }
    base_link { nil }
    cost { nil }
    deck_limit { 3 }
    faction { 'Neutral' }
    influence_cost { nil }
    influence_limit { nil }
    memory_cost { nil }
    minimum_deck_size { nil }
    side { nil }
    strength { nil }
    subtype { nil }
    text { 'Test text' }
    title { 'Test' }
    trash_cost { nil }
    type { 'Event' }
    unique { false }

    trait :agenda do
      advancement_requirement { 3 }
      agenda_points { 5 }
      influence_cost { 0 }
      side { 'Corp' }
      text { 'Test Agenda text' }
      title { 'Test Agenda' }
      type { 'Agenda' }
    end

    trait :asset do
      cost { 3 }
      influence_cost { 0 }
      side { 'Corp' }
      subtype { 'Ritzy' }
      text { 'Test Asset text' }
      title { 'Test Asset' }
      trash_cost { 3 }
      type { 'Asset' }
    end
  end
end
