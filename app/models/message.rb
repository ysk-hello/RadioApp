class Message < ApplicationRecord
    belongs_to :program, primary_key: :id, foreign_key: :program_id

    validates :name, presence: true
    validates :content, presence: true
    validates :delete_password, presence: true 
end
