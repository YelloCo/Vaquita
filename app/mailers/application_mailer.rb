class ApplicationMailer < ActionMailer::Base
  default from: Settings.vaquita.email_from
  layout 'mailer'
end
