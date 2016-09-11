class Player < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :messages
  belongs_to :card, optional: true
end
