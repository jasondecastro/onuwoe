class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.belongs_to :player, foreign_key: true
      t.string :role
      t.text :action
      t.string :team

      t.timestamps
    end
  end
end
