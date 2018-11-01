module DeltaScheduler
  def set_schedule(time, frequency, repo_id)
    return if using_console?

    job_id = Rufus::Scheduler.singleton.cron cron_entry(time, frequency) do
      Rails.logger.info('Scheduler starting')
      Delta.new(repo_id).execute
      Rails.logger.info('Scheduler stopping')
    end

    job_id
  end

  def cancel_schedule(job_id)
    s = Rufus::Scheduler.singleton
    s.unschedule(job_id) if s.job(job_id)
  end

  def cancel_all
    Rufus::Scheduler.singleton.jobs.each do |job|
      Rufus::Scheduler.singleton.unschedule(job)
    end
  end

  private

  def using_console?
    defined?(Rails::Console) || File.split($PROGRAM_NAME).last == 'rake'
  end

  def cron_entry(time, frequency)
    hour, min = time.split(':')

    case frequency
    when 'hourly'
      '0 * * * *'
    when 'daily'
      "#{min} #{hour} * * *"
    when 'weekly'
      "#{min} #{hour} * * 1" # every Monday
    when 'monthly'
      "#{min} #{hour} 1 * *" # First day of the month
    else
      '0 * * * *'
    end
  end
end
