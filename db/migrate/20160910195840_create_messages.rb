class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.belongs_to :player, foreign_key: true
      t.belongs_to :game, foreign_key: true
    end
  end
end
