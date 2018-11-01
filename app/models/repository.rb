class Repository < ApplicationRecord
  belongs_to :user, -> { unscope(where: :is_active) }
  has_many :reviews
  default_scope { where(is_active: true) }
  validates :name, :frequency, :branch, :git_dir, presence: true
end
