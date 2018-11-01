class User < ApplicationRecord
  devise :database_authenticatable, :lockable, :invitable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  default_scope { where(is_active: true) }

  # this method is called by devise to check for "active" state of the model
  def active_for_authentication?
    super && is_active?
  end
end
