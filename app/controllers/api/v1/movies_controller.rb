class API::V1::MoviesController < ApplicationController
  def index

    if Movie::DAYS.include?(list_movie_params)
      @movies = Movie.filter_by_day(list_movie_params)
      render json: @movies
    else
      render json: {error: 'Day must be a valid day' }, status: :unprocessable_entity
    end
  end
  
  def create
    @movie = Movie.new movie_params
    if @movie.save
      render json: MovieDecorator.new(@movie), status: :created
    else 
      render json: {errors: @movie.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def movie_params
    params.permit(:name, :description, :image_url, :days)
  end
  
  def list_movie_params
    params.require(:days)
  end
end
