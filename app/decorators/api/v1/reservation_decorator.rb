class API::V1::ReservationDecorator < Draper::Decorator
  delegate :id, :date, :movie_name, :client_fullname, :seats

  def movie_name
    object.movie.name
  end
end
