require 'rails_helper'

describe 'after creation' do
  it 'sends a confirmation email' do
    user = FactoryBot.build(:user)
    user.confirmation_token = nil
    user.confirmed_at = nil
    user.confirmation_sent_at = nil
    expect { user.save }.to change(Devise.mailer.deliveries, :count).by(1)
  end
end
