require 'rails_helper'

RSpec.describe "API::V1::Reservations", type: :request do
  describe '#index' do
    before do
      @movie = Movie.create(name: 'Dummy', description: 'Dummy', image_url: nil, days: 'mon,tue')
      @reservation = Reservation.create(movie_id: @movie.id, date: '2020-03-30', client_fullname: 'John Doe', seats: 2)
    end

    context 'when params are valid and list have items' do
      let(:url) { '/api/v1/reservations?start_date=2020-03-01&end_date=2020-04-01' }
      
      it 'retrieve a list with all reservations' do
        get url
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body).count).to eq(1)
      end
    end

    context 'when params are valid but list is empty' do
      let(:url) { '/api/v1/reservations?start_date=2020-01-01&end_date=2020-02-01' }
      
      it 'retrieve an empty list' do
        get url
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body).count).to eq(0)
      end
    end

    context 'when params are not valid' do
      let(:url) { '/api/v1/reservations?start_date=2020-03-01&end_date=2020-03-33' }
      
      it 'retrieve an error' do
        get url
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)["error"]).to include('Date range must have both valid dates')
      end
    end
  end

  describe '#create' do
    before do
      @movie = Movie.create(name: 'Test', description: 'Test', image_url: nil, days: 'sat,sun')
      @reservation = Reservation.create(movie_id: @movie.id, date: '2020-03-29', client_fullname: 'John Doe', seats: 2)
    end

    context 'when params are valid' do
      context 'and all validations are passed' do
        let(:url) { '/api/v1/reservations' }
        let(:params) { {params: {movie_id: @movie.id, date: '2020-03-29', client_fullname: 'John Doe', seats: 2}} }
        
        it 'creates a movie successfully' do
          post url, params
          expect(response.status).to eq(201)
          expect(change { Reservation.count }.by(1))
        end
      end

      context 'but validations failed' do
        let(:url) { '/api/v1/reservations' }
        let(:params) { {params: {movie_id: @movie.id, date: '2020-03-33', client_fullname: 'John Doe', seats: 2}} }

        it 'returns an error' do
          post url, params
          expect(response.status).to eq(422)
        end
      end

      context 'but seats are not available' do
        let(:url) { '/api/v1/reservations' }
        let(:params) { {params: {movie_id: @movie.id, date: '2020-03-29', client_fullname: 'John Doe', seats: 9}} }

        it 'returns an error' do
          post url, params
          expect(response.status).to eq(422)
          expect(JSON.parse(response.body)["errors"]).to include('Seats are not available')
        end
      end
    end

    context 'when params are not valid' do
      let(:url) { '/api/v1/reservations' }
      let(:params) { {params: {movie_id: nil, date: '2020-03-30', client_fullname: nil, seats: nil}} }
      
      it 'retrieve an error' do
        post url, params
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)["errors"]).to include('Movie must exist')
      end
    end
  end
end
