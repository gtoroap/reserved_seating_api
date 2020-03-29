require 'rails_helper'

RSpec.describe "API::V1::Movies", type: :request do

  before do
    @movie = Movie.create(name: 'Dummy', description: 'Dummy', image_url: nil, days: 'mon,tue')
  end

  describe '#index' do
    context 'when params are valid and list have items' do
      let(:url) { '/api/v1/movies?days=mon' }
      
      it 'retrieve a list with all movies' do
        get url
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body).count).to eq(1)
      end
    end

    context 'when params are valid but list is empty' do
      let(:url) { '/api/v1/movies?days=fri' }
      
      it 'retrieve an empty list' do
        get url
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body).count).to eq(0)
      end
    end

    context 'when params are not valid' do
      let(:url) { '/api/v1/movies?days=jan' }
      
      it 'retrieve an error' do
        get url
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)).to include('error')
      end
    end
  end

  describe '#create' do
    context 'when params are valid' do
      let(:url) { '/api/v1/movies' }
      let(:params) { {params: {name: 'Test', description: 'Test', days: 'mon,tue'}} }
      
      it 'creates a movie successfulyy' do
        post url, params
        expect(response.status).to eq(201)
        expect(change { Movie.count }.by(1))
      end
    end

    context 'when params are not valid' do
      let(:url) { '/api/v1/movies' }
      let(:params) { {params: {name: nil, description: 'Test', days: 'jan,feb'}} }
      
      it 'creates a movie successfulyy' do
        post url, params
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)).to include('errors')
      end
    end
  end
end
