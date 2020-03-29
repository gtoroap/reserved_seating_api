class Movie < ApplicationRecord
  DAYS = %w(mon tue wed thu fri sat sun)
  
  scope :filter_by_day, ->(day) { where("days LIKE ?", "%#{day}%") }
end
