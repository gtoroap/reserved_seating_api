module API
  module V1
    class ReservationsController < ApplicationController
      def index
        date_range = Reservation.valid_date_range(date_reservation_params[:start_date], date_reservation_params[:end_date])
        if date_range
          @reservations = Reservation.filter_by_date_range(date_range)
          render json: @reservations
        else
          render json: {error: 'Date range must have both valid dates' }, status: :unprocessable_entity
        end
      end

      def create
        @reservation = Reservation.new reservation_params
        if @reservation.save
          render json: ReservationDecorator.new(@reservation), status: :created
        else
          render json: {errors: @reservation.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def reservation_params
        params.permit(:movie_id, :date, :client_fullname, :seats)
      end

      def date_reservation_params
        params.permit(:start_date, :end_date)
      end
    end
  end
end