class Message < ApplicationRecord
    belongs_to :program, primary_key: :id, foreign_key: :program_id
end
