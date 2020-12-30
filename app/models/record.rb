class Record < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :first_year, presence: true
  validates :webarchive, presence: true, uniqueness: true
#  VALID_LINK_REGEX =
#  validates :link, format: { with: VALID_LINK_REGEX }

  #regex webarchive links
  #regex web links
end
