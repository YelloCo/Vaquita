class RepositoriesController < ApplicationController
  include DeltaScheduler
  include RepositoriesHelper
  before_action :set_repository, only: %w[show edit update destroy]

  def index
    @repositories = Repository.all
  end

  def show; end

  def new
    @repository = Repository.new(
      branch: '/master',
      time: (Time.now + 1.hour).strftime('%k:00'),
      frequency: :daily
    )
  end

  def edit; end

  def create
    @repository = Repository.new(repository_params.merge(user: current_user))

    if @repository.save
      save_and_set_schedule
      redirect_to repositories_url, notice: 'Repository was successfully created.'
    else
      render :new
    end
  end

  def update
    if @repository.update(repository_params)
      cancel_schedule(@repository.scheduler_job) if @repository.scheduler_job
      save_and_set_schedule
      redirect_to repositories_url, notice: 'Repository was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    cancel_schedule(@repository.scheduler_job) if @repository.scheduler_job
    @repository.update_attributes!(is_active: false)
    redirect_to repositories_url, notice: 'Repository was successfully deactivated.'
  end

  private

  def save_and_set_schedule
    job_id = set_schedule(@repository.time, @repository.frequency, @repository.id)
    @repository.update_attributes(scheduler_job: job_id)
  end

  def set_repository
    @repository = Repository.find(params[:id])
  end

  def repository_params
    params.require(:repository).permit(:name, :git_dir, :branch, :frequency,
                                       :time, :last_commit, :ignores, :remote_url,
                                       :remote_token, :remote_type, :remote_repository,
                                       :notification_emails)
  end
end
