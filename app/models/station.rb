class Station < ApplicationRecord
    self.primary_key = :code

    has_many :available_stations, primary_key: :code, foreign_key: :station_code    # 連関と同じ順番
    has_many :programs, primary_key: :code, foreign_key: :station_code
end
