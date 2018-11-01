module ApplicationHelper
  PAGE_TITLES = {
    confirmations: { new: 'Resend Confirmation' },
    dashboard: { index: 'Dashboard' },
    invitations: { edit: 'Set Password' },
    passwords: { new: 'Forgot Password', edit: 'Reset Password' },
    registrations: { edit: 'Update Account' },
    repositories: { new: 'Create Repository', edit: 'Edit Repository' },
    reviews: { edit: 'Edit Review', show: 'View Review', complete: 'Complete Review' },
    sessions: { new: 'Login' },
    unlocks: { new: 'Unlock Account' },
    users: { new: 'Invite User', show: 'View User', edit: 'Edit User' }
  }.freeze

  def find_page_title
    PAGE_TITLES.dig(controller_name.to_sym, action_name.to_sym) || controller_name.titleize
  end
end
