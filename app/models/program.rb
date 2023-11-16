class Program < ApplicationRecord
    has_many :messages, primary_key: :id, foreign_key: :program_id
    belongs_to :station, primary_key: :code, foreign_key: :station_code
end
