FactoryBot.define do
  factory :exercise do
    routine
    name { 'Name' }
    link { 'Link' }
    sets { 3 }
    reps { 15 }
    rest { 90 }
    tempo { '50x1' }
  end
end
