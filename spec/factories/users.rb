FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { 'f4k3p455w0rd' }
    name { 'test user' }
    confirmation_token { 'abcdefg' }
    confirmed_at { 2.days.ago }
    confirmation_sent_at { 3.days.ago }
  end
end
