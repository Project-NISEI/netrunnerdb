require 'rails_helper'

feature 'Visitor requires new password' do
  scenario 'clicks on link and enters correct email' do
    user = FactoryBot.create(:user)
    visit '/users/password/new'
    fill_in 'Email', :with => user.email
    expect { click_button 'Send me reset password instructions' }.to change(Devise.mailer.deliveries, :count).by(1)
    expect(page).to have_text('You will receive an email with instructions on how to reset your password in a few minutes.')
  end

  scenario 'clicks on link and enters incorrect email' do
    FactoryBot.create(:user)
    visit '/users/password/new'
    fill_in 'Email', :with => 'thisemaildoesnotexist@doesntexist.com'
    expect { click_button 'Send me reset password instructions' }.to change(Devise.mailer.deliveries, :count).by(0)
    expect(page).to have_text('Email not found')
  end
end
