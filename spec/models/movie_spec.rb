require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:valid_movie) { Movie.new(name: 'Dummy', description: 'Dummy', image_url: nil, days: 'mon,tue')}
  let(:invalid_movie) { Movie.new(name: nil, description: 'Dummy', image_url: nil, days: 'jan,feb')}

  context 'when a Movie instance is valid' do
    it "should return true" do
      expect(valid_movie.valid?).to be_truthy
    end
  end

  context 'when a Movie instance is not valid' do
    it "should return false" do
      expect(invalid_movie.valid?).to be_falsy
    end

    it "should return error messages" do
      invalid_movie.valid?
      expect(invalid_movie.errors).to_not be_empty
      expect(invalid_movie.errors.count).to eq(1)
    end
  end
end
