require 'rails_helper'

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    visit '/users/sign_up'
    fill_in 'Email', :with => 'test@test.com'
    fill_in 'Name', :with => 'Test User'
    fill_in 'Password', :with => 'password'
    fill_in 'Password confirmation', :with => 'password'
    click_button 'Sign up'
    expect(page).to have_text('A message with a confirmation link has been sent to your email address.')
  end

  scenario 'with invalid email' do
    visit '/users/sign_up'
    fill_in 'Email', :with => 'this is a bad email'
    fill_in 'Name', :with => 'Test User'
    fill_in 'Password', :with => 'password'
    fill_in 'Password confirmation', :with => 'password'
    click_button 'Sign up'
    expect(page).to have_text('Email is invalid')
  end

  scenario 'without a name' do
    visit '/users/sign_up'
    fill_in 'Email', :with => 'test@test.com'
    fill_in 'Password', :with => 'password'
    fill_in 'Password confirmation', :with => 'password'
    click_button 'Sign up'
    expect(page).to have_text('Name can\'t be blank')
  end

  scenario 'with mismatching passwords' do
    visit '/users/sign_up'
    fill_in 'Email', :with => 'test@test.com'
    fill_in 'Name', :with => 'Test User'
    fill_in 'Password', :with => 'password'
    fill_in 'Password confirmation', :with => 'password123456'
    click_button 'Sign up'
    expect(page).to have_text('Password confirmation doesn\'t match Password')
  end
end
