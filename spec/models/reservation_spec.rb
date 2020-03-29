require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:movie) { Movie.create(name: 'Dummy', description: 'Dummy', image_url: nil, days: 'sat,sun,mon')}
  let(:valid_reservation) { Reservation.new(movie_id: movie.id, date: '2020-03-22', seats: 2)}
  let(:invalid_reservation) { Reservation.new(movie_id: nil, date: '2020-03-222', seats: 0)}

  context 'when a Reservation instance is valid' do
    it "should return true" do
      expect(valid_reservation.valid?).to be_truthy
    end
  end

  context 'when a Reservation instance is not valid' do
    it "should return false" do
      expect(invalid_reservation.valid?).to be_falsy
    end

    it "should return error messages" do
      invalid_reservation.valid?
      expect(invalid_reservation.errors).to_not be_empty
      expect(invalid_reservation.errors.count).to eq(2)
    end
  end
end
