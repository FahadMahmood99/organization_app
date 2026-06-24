class Member < ApplicationRecord
  belongs_to :team

  has_many :member_projects, dependent: :destroy
  has_many :projects, through: :member_projects

  validates :first_name, presence: true
  validates :last_name, presence: true
end
