require_relative '../models/review'
require_relative 'repo_helper'

class Delta
  def initialize(repo_id)
    @repo_id = repo_id
  end

  def execute
    helper.check_for_valid_repo_dir(git_dir)
    last_commit = repo.last_commit || find_first_commit
    new_commit = find_latest_commit

    return if new_commit == last_commit

    diff = helper.git_diff(git_dir, options(last_commit, new_commit))
    repo.update_attributes(last_commit: new_commit)

    return if diff.empty?

    create_review(
      diff: escape_diff(diff),
      raw_diff: diff,
      beginning_commit: last_commit,
      ending_commit: new_commit
    )
  end

  private

  def helper
    @helper ||= repo.remote_repository ? remote_helper : RepoHelper
  end

  def escape_diff(diff)
    CGI.escapeHTML(diff).encode('UTF-8', invalid: :replace)
  end

  def find_latest_commit
    helper.git_latest_commit(git_dir, working_branch)
  end

  def find_first_commit
    helper.git_first_commit(git_dir, 'master')
  end

  def options(last_commit, new_commit)
    {
      ignores: ignores,
      last_commit: last_commit,
      new_commit: new_commit
    }
  end

  def create_review(args)
    Review.create!(
      diff: Ansi::To::Html.new(args[:diff]).to_html(:solarized),
      raw_diff: args[:raw_diff],
      status: 'New',
      name: "Branch #{working_branch} up to #{args[:ending_commit][0..7]}",
      repository: repo,
      beginning_commit: args[:beginning_commit],
      ending_commit: args[:ending_commit],
      branch: working_branch
    )
  end

  def repo
    return @repo.reload if @repo
    @repo = Repository.find(@repo_id)
  end

  def working_branch
    @working_branch ||= set_working_branch
  end

  def set_working_branch
    branches = helper.git_branches(git_dir, repo.branch)
    raise "Cannot find branch matching criteria(#{git_dir}:#{repo.branch})" unless branches.present?
    branches.max&.chomp
  end

  def git_dir
    @git_dir ||= repo.git_dir
  end

  def ignores
    @ignores ||= repo.ignores.split("\n").collect(&:chomp)
  end

  def remote_helper
    case repo.remote_type
    when 'gitlab'
      GitlabHelper.new(repo)
    when 'github'
      GithubHelper.new(repo)
    end
  end
end
