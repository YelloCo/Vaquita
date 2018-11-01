require 'rails_helper'

RSpec.feature 'Dashboard' do
  let(:user) { create(:user) }
  let!(:repository) { create(:repository, user: user) }
  before(:each) { login_as(user) }

  it 'shows the correct number of dashboard panels' do
    visit '/'
    expect(page).to have_current_path('/')
    expect(panel_count).to eq(1)
  end

  context 'an outstanding review is created' do
    it 'increments the outstanding counter' do
      create(:review, repository: repository)
      visit '/'
      expect(page).to have_content('Outstanding Reviews 1')
    end
  end

  context 'an outstanding review is completed' do
    let!(:review) { create(:review, repository: repository, status: 'Completed') }
    before(:each) { visit '/' }

    it 'decrements the outstanding counter' do
      expect(page).to have_content('Outstanding Reviews 0')
    end

    it 'increments the completed reviews counter' do
      expect(page).to have_content('Completed Reviews 1')
    end

    it 'does not affect the issues found counter' do
      expect(page).to have_content('Issues Found 0')
    end
  end

  private

  def panel_count
    page.all('nav.level').count
  end
end
