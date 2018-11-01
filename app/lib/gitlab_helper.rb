class GitlabHelper
  def initialize(repository)
    @repo = repository
    @client = Gitlab.client(
      endpoint: base_url,
      private_token: @repo.remote_token
    )
  end

  def check_for_valid_repo_dir(git_dir)
    raise "Not a valid git repository: #{git_dir}" unless project
  end

  def git_branches(_git_dir, branch)
    branches = []
    @client.branches(project.id, per_page: 100).each_page do |page|
      branches << page.collect { |b| "/#{b.name}".match?(branch) ? b.name : nil }
    end
    branches.flatten.compact
  end

  def git_latest_commit(_git_dir, branch_name)
    @client.branch(project.id, branch_name).commit.id
  end

  def git_first_commit(_git_dir, branch_name)
    branch_name[0] = '' if branch_name[0] == '/'

    options = {
      ref_name: branch_name,
      per_page: 2
    }

    # By default the API returns sorted by created_by
    fetch_latest_commits(options).last
  end

  def git_diff(_git_dir, options)
    old = options[:last_commit]
    latest = options[:new_commit]
    diffs = @client.compare(project.id, old, latest).diffs
    filter_diffs(diffs, options[:ignores])
  end

  private

  def base_url
    uri = URI.parse(@repo.remote_url)
    "#{uri.scheme}://#{uri.host}/api/v4"
  end

  def project
    @project ||= fetch_project
  end

  def fetch_project
    projects = @client.projects(
      per_page: 100,
      simple: true,
      search: @repo.git_dir.split('/').last
    )
    projects.find { |p| p.path_with_namespace.downcase == @repo.git_dir }
  end

  def fetch_latest_commits(options)
    @client.commits(project.id, options).collect(&:id)
  end

  def filter_diffs(diffs, ignores)
    ignored_files = PathSpec.from_lines(ignores)
    filtered = diffs.each_with_object([]) do |diff, result|
      unless diff['renamed_file'] || diff['deleted_file'] || ignored_files.match(diff['new_path'])
        result << diff['diff']
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
end
