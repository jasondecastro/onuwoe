class CreateRounds < ActiveRecord::Migration[5.0]
  def change
    create_table :rounds do |t|
      t.belongs_to :game
      t.boolean :complete
      t.boolean :current
      t.integer :number

      t.timestamps
    end
  end
end
