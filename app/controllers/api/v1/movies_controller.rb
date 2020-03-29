class API::V1::MoviesController < ApplicationController
  def index
    @movies = Movie.all
    render @movies
  end
  
  def create
    @movie = Movie.new movie_params
    if @movie.save
      render json: @movie, status: :created
    else 
      render json: {errors: @movie.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def movie_params
    params.permit(:name, :description, :image_url, :days)
  end
end
