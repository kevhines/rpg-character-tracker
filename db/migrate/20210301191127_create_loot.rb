class CreateLoot < ActiveRecord::Migration[5.2]
  def change
    create_table :loot do |t|
      t.string :loot
      t.integer :quantity
      t.boolean :secret
      t.integer :user_id
    end
  end
end
