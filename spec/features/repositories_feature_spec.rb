require 'rails_helper'

RSpec.feature 'Repositories', js: true do
  let(:user) { create(:user) }
  before(:each) { login_as(user) }
  before(:each) { create_repository(build(:repository)) }

  context 'you create a repository' do
    it 'adds the repository to the index page' do
      visit repositories_path
      expect(row_count).to eq(1)
    end

    it 'initiates the background scheduler' do
      repo = Repository.all.first
      expect(job_count).to eq(1)
      time = repo.time.split(':')
      cron_line = scheduler.jobs.first.cron_line
      expect(cron_line.original).to eq("#{time[1]} #{time[0]} * * *")
    end
  end

  context 'you edit a repository' do
    it 'updates the repository on the index page' do
      first_row = page.all('table > tbody > tr').first
      first_row.find_link('Edit').click

      page.find_field('Directory').set('./meow')
      page.find_button('Submit').click

      updated_first_row = page.all('table > tbody > tr').first
      expect(updated_first_row).to have_content('./meow')
    end

    it 'updates the background scheduler' do
      first_row = page.all('table > tbody > tr').first
      first_row.find_link('Edit').click

      page.find_field('Time').set('02:24PM')
      page.find_button('Submit').click

      # Still only 1 scheduler since it should delete the original
      expect(job_count).to eq(1)
      cron_line = scheduler.jobs.first.cron_line
      expect(cron_line.original).to eq('24 14 * * *')
    end
  end

  context 'you delete a repository' do
    it 'removes the repository from the index page' do
      repository = Repository.all.first
      delete_repository(repository)
      visit repositories_path
      expect(page).to_not have_content(repository.name)
    end

    it 'removes the background scheduler' do
      repository = Repository.all.first
      delete_repository(repository)
      expect(job_count).to eq(0)
    end

    it 'still shows the reviews attached to the repository' do
    end
  end

  private

  def row_count
    page.all('table > tbody > tr').count
  end

  def scheduler
    Rufus::Scheduler.singleton
  end

  def job_count
    scheduler.jobs.count
  end

  def create_repository(repo)
    visit new_repository_path
    fill_in_fields(repo)
    page.find_button('Submit').click
  end

  def fill_in_fields(repo)
    page.find_field('Name').set(repo.name)
    page.find_field('Directory').set('.')
    page.find_field('Frequency').set(repo.frequency)
    page.find_field('Time').set(repo.time.to_s + am_or_pm(repo.time))
  end

  def delete_repository(repo)
    visit repositories_path
    page.driver.execute_script('window.confirm = function(){return true;}')
    page.find("a[href='/repositories/#{repo.id}']").click
  end

  def am_or_pm(time)
    time.to_s.split(':').first.to_i < 12 ? 'AM' : 'PM'
  end
end
