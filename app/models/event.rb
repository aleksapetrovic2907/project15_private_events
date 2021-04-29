class Event < ApplicationRecord
    belongs_to :creator, class_name: "User"
    validates :title, :description, :date_time, :location, presence: true
    scope :past, -> { where('date_time < ?', Date.today).order(date_time: :desc) }
    scope :upcoming, -> { where('date_time > ?', Date.today).order(:date_time) }
end
