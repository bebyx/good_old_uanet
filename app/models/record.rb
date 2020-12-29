class Record < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :first_year, presence: true
  validates :webarchive, presence: true, uniqueness: true
end
