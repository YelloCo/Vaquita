class GithubHelper
  attr_accessor :client

  def initialize(repository)
    @repo = repository
    @client = Github.new(
      oauth_token: @repo.remote_token,
      endpoint: base_url
    )
  end

  def check_for_valid_repo_dir(git_dir)
    return true if project_exists?
    raise "Not a valid git repository: #{git_dir}"
  end

  def git_branches(_git_dir, branch)
    branches = []
    @client.repos.branches.list(user, project, per_page: 100).each_page do |page|
      page.each_with_object(branches) do |b, result|
        result << b.name if "/#{b.name}".match?(branch)
      end
    end
    branches
  end

  def git_latest_commit(_git_dir, branch_name)
    branch_name[0] = '' if branch_name[0] == '/'
    @client.repos.branches.get(user, project, branch_name).commit.sha
  end

  def git_first_commit(_git_dir, branch_name)
    branch_name[0] = '' if branch_name[0] == '/'
    options = {
      sha: branch_name,
      per_page: 2
    }

    # By default the API returns sorted by created_by
    fetch_latest_commits(options).last
  end

  def git_diff(_git_dir, options)
    old = options[:last_commit]
    latest = options[:new_commit]
    diffs = @client.repos.commits.compare(user, project, old, latest)
    filter_diffs(diffs.files, options[:ignores])
  end

  private

  def base_url
    uri = URI.parse(@repo.remote_url)
    return 'https://api.github.com' if [uri.host, uri.path].include?('github.com')
    "#{uri.scheme}://#{uri.host}/api/v3"
  end

  def user
    @user ||= @repo.git_dir.split('/').first
  end

  def project
    @project ||= @repo.git_dir.split('/').last
  end

  def project_exists?
    @client.repos.get(user, project)
    true
  rescue Github::Error::NotFound
    false
  end

  def fetch_latest_commits(options)
    @client.repos.commits.list(user, project, options).collect(&:sha)
  end

  def filter_diffs(diffs, ignores)
    ignored_files = PathSpec.from_lines(ignores)
    filtered = diffs.each_with_object([]) do |file, result|
      unless %w[deleted renamed].include?(file.status) || ignored_files.match(file.filename)
        result << git_headers(file.filename) + file.patch
      end
      result
    end

    colorize(filtered.join(''))
  end

  def colorize(diff)
    diff.split("\n").map { |line| ansi_format(line) }.join("\n")
  end

  def ansi_format(line)
    return "\e[1m#{line}\e[m" if ['---', '+++'].include?(line[0..2])
    return "\e[31m#{line}\e[m" if line[0] == '-'
    return "\e[32m#{line}\e[m" if line[0] == '+'
    line
  end

  def git_headers(filename)
    # This is a hack since Github only provides the resulting "patch"
    # This doesn't include the extended header (usually index)
    # See: https://git-scm.com/docs/git-diff#_generating_patches_with_p bullet 2
    "diff --git a/#{filename} b/#{filename}\n--- a/#{filename}\n+++ b/#{filename}\n"
  end
end
