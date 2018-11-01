namespace :user do
  desc 'Manually email user invite link for registration'
  task create: :environment do
    print 'User email: '
    email = STDIN.gets.strip.to_sym
    u = User.invite!(email: email)
    msg = 'Check email or go to site at /users/invitation/accept?invitation_token='
    puts "#{msg}#{u.raw_invitation_token}"
  end
end
