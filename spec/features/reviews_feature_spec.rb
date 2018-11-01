require 'rails_helper'

RSpec.feature 'Reviews', js: true do
  let(:user) { create(:user) }
  let!(:repository) { create(:repository, user: user) }
  before(:each) { login_as(user) }

  context 'there is an outstanding review' do
    it 'displays on the index page' do
      review = create(:review, repository: repository)
      visit '/reviews'
      expect(page).to have_content(review.name)
    end

    it 'can be completed' do
    end
  end

  context 'there are many total reviews on the index page' do
    before do
      create_many_reviews
    end

    it 'can go forward one page' do
      visit '/reviews'
      initial_content = page.text
      page.find_link('Next').click
      expect(page.text).to_not eq(initial_content)
    end

    it 'can go back one page' do
      visit '/reviews'
      initial_content = page.text
      page.find_link('Next').click
      expect(page.text).to_not eq(initial_content)
      page.find_link('Previous').click
      expect(page.text).to eq(initial_content)
    end

    it 'can traverse to an exact page number' do
      visit '/reviews'
      initial_content = page.text
      page.find_link('2').click
      expect(page.text).to_not eq(initial_content)
      page.find_link('1').click
      expect(page.text).to eq(initial_content)
    end

    it 'can be filtered upon by repository' do
      visit '/reviews'
      repo = create(:repository, user: user)
      create(:review, repository: repo)
      page.find_field('filter[value]').set(repo.name)
      page.find(:css, 'button[type=submit]').click
      expect(page.all('table tbody tr').count).to eq(1)
    end

    it 'can be filtered upon by status' do
      visit '/reviews'
      create(:review, repository: repository, status: :completed)
      page.select('Status', from: 'filter[key]')
      page.find_field('filter[value]').set('completed')
      page.find(:css, 'button[type=submit]').click
      expect(page.all('table tbody tr').count).to eq(Review.where(status: :completed).count)
    end
  end

  context 'you try to complete the review' do
    it 'shows the code difference' do
      review = create(:review, repository: repository)
      visit '/reviews'
      page.find_link('Complete').click
      expect(page).to have_content(review.diff)
    end

    it 'can be completed with a review' do
      create(:review, repository: repository)
      visit '/reviews'
      page.find_link('Complete').click

      page.find_button('Attach Issue').click
      issue = fill_out_issue_details
      expect(page).to have_content(issue[:title])

      page.find_button('Complete Review').click
      expect(page).to have_content(user.email)
    end
  end

  private

  def create_many_reviews
    25.times do
      create(:review, repository: repository)
    end
  end

  def fill_out_issue_details
    details = {
      title: "Meow #{SecureRandom.hex(4)}",
      description: "Catz #{SecureRandom.hex(6)}",
      tracking_url: "http://example.com?q=#{SecureRandom.hex(4)}"
    }
    page.find_field('Title').set(details[:title])
    page.find_field('Description').set(details[:description])
    page.find_field('Tracking url').set(details[:tracking_url])
    page.find_button('Save').click
    details
  end
end
