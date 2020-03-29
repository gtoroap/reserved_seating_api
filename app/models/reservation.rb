class Reservation < ApplicationRecord
  belongs_to :movie

  AVAILABLE_SEATS = 10

  scope :filter_by_date_range, ->(date_range) { where(date: date_range) }

  validates_presence_of :date, :seats

  validate :valid_date, on: :create
  validate :valid_date_range
  validate :available_seats

  def valid_date
    begin
      parsed_date = Date.parse(date).wday
      formatted_date = Date::DAYNAMES[parsed_date].downcase[0..2]
      movie = Movie.find_by(id: movie_id)
      if movie
        movie_days = movie.days
        is_valid = movie_days.split(',').include?(formatted_date)
        errors.add(:date, 'is not displaying this movie') unless is_valid
      end
    rescue Date::Error
      errors.add(:date, 'is not a valid date')
    end
  end

  def available_seats
    reserved_seats = Reservation.where(movie_id: movie_id, date: date).map(&:seats)
    errors.add(:seats, 'are not available') unless (reserved_seats.sum + seats.to_i <= AVAILABLE_SEATS)
  end

  class << self
    def valid_date_range(start_date, end_date)
      begin
        Date.parse(start_date)..Date.parse(end_date)
      rescue Date::Error
        nil
      end
    end
  end
end
