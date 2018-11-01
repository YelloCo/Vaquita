require_relative "#{Rails.root}/app/lib/delta_scheduler"
include DeltaScheduler

unless defined?(Rails::Console) || File.split($PROGRAM_NAME).last == 'rake'
  Repository.all.each do |repo|
    puts "Initializing scheduler for repository #{repo.name}"
    cancel_schedule(repo.scheduler_job)
    set_schedule(
      repo.time, 
      repo.frequency,
      repo.id
    )
  end
end
