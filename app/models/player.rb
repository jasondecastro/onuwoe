class Player < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_one :card
end
