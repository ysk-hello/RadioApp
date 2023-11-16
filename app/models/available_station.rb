class AvailableStation < ApplicationRecord
    belongs_to :prefecture, primary_key: :code, foreign_key: :prefecture_code
    belongs_to :station, primary_key: :code, foreign_key: :station_code
end
