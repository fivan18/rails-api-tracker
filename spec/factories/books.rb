FactoryBot.define do
    factory :book do
        sequence(:title) { |n| "Title #{n}"}
        sequence(:author) { |n| "Author #{n}"}
    end
end