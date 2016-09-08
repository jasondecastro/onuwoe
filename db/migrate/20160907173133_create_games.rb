class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :state
      t.string :host

      t.timestamps
    end
  end
end
