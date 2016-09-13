class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :nickname
      t.string :final_card
      t.integer :votes, :default => 0
      t.belongs_to :game, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.belongs_to :card, foreign_key: true

      t.timestamps
    end
  end
end
