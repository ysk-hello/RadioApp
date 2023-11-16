class Prefecture < ApplicationRecord
    self.primary_key = :code

    has_many :available_stations, primary_key: :code, foreign_key: :prefecture_code
end
