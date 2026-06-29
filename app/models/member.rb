class Member < ApplicationRecord
  belongs_to :team

  scope :only_active, -> { where(status: :active) }

    enum :status, {
    active: 0,
    inactive: 1
  }

  has_many :member_projects, dependent: :destroy
  has_many :projects, through: :member_projects

  validates :first_name, presence: true
  validates :last_name, presence: true
end
