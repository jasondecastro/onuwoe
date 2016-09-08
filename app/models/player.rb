class Player < ApplicationRecord
  belongs_to :game
  belongs_to :user
  belongs_to :card, optional: true
end
