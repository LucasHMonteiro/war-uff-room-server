class Room < ApplicationRecord
    has_many :players, dependent: :delete_all
end
