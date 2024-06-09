# frozen_string_literal: true

class Station < ApplicationRecord
  has_many :arrivals, dependent: :destroy
  has_many :walks, through: :arrivals
  has_one :station, class_name: 'Station', inverse_of: :clockwise_next_station, dependent: :destroy
  belongs_to :clockwise_next_station, class_name: 'Station', inverse_of: :station
  validates :name, presence: true
  validates :longitude, presence: true, numericality: true, uniqueness: { scope: :latitude }
  validates :latitude, presence: true, numericality: true
  validates :clockwise_distance_to_next, presence: true, numericality: true

  def next(clockwise:)
    if clockwise
      next_id = id == Station.count ? 1 : id + 1
      Station.find(next_id)
    else
      Station.find_by(clockwise_next_station: self)
    end
  end

  def self.total_distance
    Station.all.sum(&:clockwise_distance_to_next)
  end

  def distance_to_next(clockwise:)
    if clockwise
      clockwise_distance_to_next
    else
      self.next(clockwise:).clockwise_distance_to_next
    end
  end
end
