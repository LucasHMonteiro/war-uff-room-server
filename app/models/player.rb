class Player < ApplicationRecord
    belongs_to :room
    validates :identity, uniqueness: true
end
