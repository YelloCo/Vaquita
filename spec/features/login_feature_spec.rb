require 'rails_helper'

RSpec.feature 'Login' do
  context 'visit the home page' do
    before(:each) { visit '/' }

    it 'redirects to the login page' do
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context 'visits the login page' do
    before(:each) { visit new_user_session_path }

    it 'blocks an invalid login' do
      sign_in('meow@example.com', '123')

      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content('Invalid Email or password')
    end

    it 'allows a valid login' do
      user = create(:user)

      sign_in(user.email, user.password)

      expect(page).to have_current_path('/')
      expect(page).to have_content('Dashboard')
    end

    it 'has the correct links' do
      expect(page).to have_link('Forgot your password?')
      expect(page).to have_link("Didn't receive unlock instructions?")
    end
  end

  context 'visits the forgot password page' do
    before(:each) do
      visit new_user_password_path
      clear_emails
    end

    it 'sends a reset password email' do
      user = create(:user)
      page.find_field('Email').set(user.email)
      page.find_button('Send reset password instructions').click
      expect(page).to have_current_path(new_user_session_path)
      expect(latest_email).to have_content('Change my password')
    end
  end

  context 'visits the unlock instructions page' do
    before(:each) do
      visit new_user_session_path
      clear_emails
    end

    it 'sends the instructions email' do
      user = create(:user)
      8.times do
        sign_in(user.email, '123')
      end

      expect(latest_email).to have_content('Unlock my account')

      clear_emails
      page.find_link("Didn't receive unlock instructions?").click
      page.find_field('Email').set(user.email)
      page.find_button('Resend unlock instructions').click
      expect(page).to have_current_path(new_user_session_path)
      expect(latest_email).to have_content('Unlock my account')
    end
  end

  private

  def sign_in(email, password)
    page.find_field('Email').set(email)
    page.find_field('Password').set(password)
    page.find_button('Log in').click
  end

  def clear_emails
    ActionMailer::Base.deliveries = []
  end

  def latest_email
    ActionMailer::Base.deliveries.first
  end
end
