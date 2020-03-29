class Movie < ApplicationRecord
  DAYS = %w(mon tue wed thu fri sat sun)

  scope :filter_by_day, ->(day) { where("days LIKE ?", "%#{day}%") }

  has_many :movies
  
  validates_presence_of :name, :description, :days
end
