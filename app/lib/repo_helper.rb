module RepoHelper
  class << self
    def check_for_valid_repo_dir(git_dir)
      raise "Not a valid git repository: #{git_dir}" unless git_dir?(git_dir)
    end

    # TODO: Get rid of shell commands and use Ruby instead
    # TODO: Use a gem that exposes Git with native Ruby syntax (and supports Windows)
    def git_branches(git_dir, branch)
      git_fetch(git_dir)
      `git -C #{sanitize(git_dir)} ls-remote | grep '#{diff_sanitize(branch)}' | awk '{print $2}' |\
       cut -d '/' -f 3,4 | cut -d '^' -f 1 | uniq`.lines
    end

    def git_latest_commit(git_dir, branch_name)
      `git -C #{sanitize(git_dir)} log -n 1 origin/#{sanitize(branch_name)}\
       --pretty=format:"%H"`.strip
    end

    def git_first_commit(git_dir, branch_name)
      `git -C #{sanitize(git_dir)} log origin/#{sanitize(branch_name)}\
       --pretty=format:"%H" | sed -n 2p`.strip
    end

    def git_diff(git_dir, options)
      old = sanitize(options[:last_commit])
      latest = sanitize(options[:new_commit])
      ignore_opts = options[:ignores].collect { |i| "':!#{diff_sanitize(i)}'" }
      `git -C #{sanitize(git_dir)} diff --color --diff-filter=AMC #{old}..#{latest}\
       -- . #{ignore_opts.join(' ')}`.chomp
    end

    private

    def sanitize(str)
      Shellwords.shellescape(str.encode('UTF-8'))
    end

    def diff_sanitize(str)
      # These are wrapped in single quotes and should be taken literally
      str.encode('UTF-8').delete("'").gsub(/\n/, "'\n'")
    end

    def git_fetch(git_dir)
      `git -C #{sanitize(git_dir)} fetch origin`
    end

    def git_dir?(git_dir)
      Dir.exist?(git_dir) && Dir.exist?(git_dir + '/.git')
    end
  end
end
