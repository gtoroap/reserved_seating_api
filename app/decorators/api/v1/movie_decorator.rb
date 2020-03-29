class API::V1::MovieDecorator < Draper::Decorator
  delegate :id, :name, :descriotion, :image_url, :days

  decorates :movie
end
