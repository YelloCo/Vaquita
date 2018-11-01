namespace :delta do
  desc 'Manually run the code diff for a project instead'
  task execute: :environment do
    print 'Project name: '
    repo_name = STDIN.gets.strip.to_sym
    Delta.new(repo_name).execute
  end
end
