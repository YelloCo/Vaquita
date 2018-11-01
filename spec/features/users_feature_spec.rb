require 'rails_helper'

RSpec.feature 'Users' do
  let(:user) { create(:user) }
  before(:each) { login_as(user) }

  context 'you are on the index page' do
    before { visit '/users' }

    it 'shows the correct number of active users' do
      expect(page.all('tbody tr').count).to eq(1)
    end
  end

  context 'you invite a user' do
    before { clear_emails }

    it 'sends the new user an invitiation email' do
      email = invite_user

      open_email(email)
      expect(current_email).to have_content('Someone has invited you')
    end

    it 'lets the new user register' do
      email = invite_user
      logout

      open_email(email)
      invite_link = current_email.find_link('Accept invitation')['href']
      visit URI.parse(invite_link).request_uri

      create_password
      expect(page).to have_content('Dashboard')
    end
  end

  private

  def invite_user
    visit '/users'
    new_email = "meow#{SecureRandom.hex(3)}@example.com"
    page.find_link('New User').click

    page.find_field('Email').set(new_email)
    page.find_button('Invite').click
    expect(page).to have_content(new_email)
    new_email
  end

  def create_password
    password = "A$#{SecureRandom.hex(8)}"
    page.find_field('Password').set(password)
    page.find_field('Password confirmation').set(password)
    page.find_button('Set my password').click
  end
end
